# Using Multipath TCP in C on macOS/iOS

To use Multipath TCP in C, you simply need to change a bit the configuration given to the connection, by selecting a Multipath TCP mode. The list of available modes is given in [the official documentation](https://developer.apple.com/documentation/network/nw_multipath_service_t). Here is an example:

```c
// request to create a new TCP connection with TLS enabled
nw_parameters_t params = nw_parameters_create_secure_tcp(
    NW_PARAMETERS_DEFAULT_CONFIGURATION, NW_PARAMETERS_DEFAULT_CONFIGURATION);
// Handover mode: Other types can be selected
nw_parameters_set_multipath_service(params, nw_multipath_service_handover);

nw_connection_t connection = nw_connection_create(endpoint, params);
```

Please, note however that the aggregate mode doesn't seem to work according to our tests.