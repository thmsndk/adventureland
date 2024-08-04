# Shut down game servers

executor

```
servers_eval('broadcast("disconnect_reason","Game Update!"); setTimeout(shutdown_routine,1);');
```

How do we shut down the appserver gracefully?

inside the adventureland folder

- make sure that we have a lib folder if it has not been installed
- this installs flask and any future requirements
  pip install -t ../lib -r ../requirements.txt
