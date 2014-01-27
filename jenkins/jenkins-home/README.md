Jenkins home volume
===================

A container that exposes a jenkins home directory as a volume. The directory and its contents are owned by user 1000.

Note: the Dockerfile expects an initialised jenkins directory (normally found in `~jenkins/.jenkins`) to ADD, from the path `jenkins_home`.