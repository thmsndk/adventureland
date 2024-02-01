# Shut down game servers

executor servers_eval('broadcast("disconnect_reason","Game Update!"); setTimeout(shutdown_routine,1);');

How do we shut down the appserver gracefully?
