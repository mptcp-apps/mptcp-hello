//
//  main.c
//  mptcp-network-client
//
//  Created by Anthony Doeraene on 08/08/2024.
//

#include <stdio.h>
#include <string.h>
#include <Network/Network.h>

static dispatch_semaphore_t semaphore;

void get(char *path, nw_connection_t conn, dispatch_queue_t queue){
    char req[1024];
    int size = sprintf(req, "GET %s HTTP/1.0\r\nUser-Agent: curl/1.0.0\r\n\n", path);
    
    dispatch_data_t data = dispatch_data_create(req, size, queue, ^{
    });
    printf("Sending request...\n");
    nw_content_context_t context = nw_content_context_create("context");
    nw_connection_send(conn, data, context, true, ^(nw_error_t  _Nullable error) {
        if (error){
            printf("Error sending %d", nw_error_get_error_code(error));
            dispatch_semaphore_signal(semaphore);
        }
    });
    
    nw_connection_receive(conn, 0, 1024, ^(dispatch_data_t  _Nullable content, nw_content_context_t  _Nullable context, bool is_complete, nw_error_t  _Nullable error) {
        if (error){
            printf("Error receiving %d", nw_error_get_error_code(error));
            dispatch_semaphore_signal(semaphore);
            return;
        }

        dispatch_data_apply(content, ^bool(dispatch_data_t  _Nonnull region, size_t offset, const void * _Nonnull buffer, size_t size) {
            char res[size+1];
            memcpy(res, buffer, size);
            res[size] = '\0';
            printf("Received %ld bytes from server:\n%s\n", size, res);
            dispatch_semaphore_signal(semaphore);
            return true;
        });
    });
}

int main(int argc, const char * argv[]) {
    dispatch_queue_t queue = dispatch_queue_create("MPTCP client queue", NULL);
    
    nw_endpoint_t endpoint = nw_endpoint_create_host("check.mptcp.dev", "443");
    nw_parameters_t params = nw_parameters_create_secure_tcp(NW_PARAMETERS_DEFAULT_CONFIGURATION, NW_PARAMETERS_DEFAULT_CONFIGURATION);
    nw_parameters_set_multipath_service(params, nw_multipath_service_handover);
    
    nw_connection_t connection = nw_connection_create(endpoint, params);
    nw_connection_set_queue(connection, queue);
    nw_release(endpoint);
    nw_release(params);
    
    semaphore = dispatch_semaphore_create(0);
    nw_connection_set_state_changed_handler(connection, ^(nw_connection_state_t state, nw_error_t _Nullable event_error) {
        switch (state) {
            case nw_connection_state_ready: {
                printf("Ready\n");
                get("/", connection, queue);
                break;
            }
            case nw_connection_state_failed:
                printf("Error: failed to create the MPTCP connection");
                dispatch_semaphore_signal(semaphore);
                break;
            case nw_connection_state_cancelled:
                printf("Error: cancelled to create the MPTCP connection");
                dispatch_semaphore_signal(semaphore);
                break;
            case nw_connection_state_waiting:
                dispatch_semaphore_signal(semaphore);
                break;
            default: {
                // Ignore other states
                break;
            }
        }
    });
    
    nw_connection_start(connection);
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_release(semaphore);
    dispatch_release(queue);
}
