#!/bin/bash

# Define the trace session name
SESSION_NAME="UserviceT"

# Define the application name (change if different)
APP_NAME="UserService"





# 1. Create a new LTTng session
echo "Creating LTTng trace session: $SESSION_NAME"
lttng create $SESSION_NAME -o /social-network-microservices/out/

# 2. Enable user-space events for function entry/exit
echo "Enabling function entry/exit tracing"
lttng enable-event -u -a   # Enable all user-space events


# 4. Start the trace session
echo "Starting LTTng tracing session"
lttng start

# 5. Run your application
echo "Launching $APP_NAME..."
# Assuming `UserService` is the name of your app binary
LTTNG_UST_ALLOW_BLOCKING=1 LTTNG_UST_DEBUG=1 LTTNG_UST_VERBOSE=1 LD_PRELOAD="/usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so /usr/lib/x86_64-linux-gnu/liblttng-ust-libc-wrapper.so" $APP_NAME
