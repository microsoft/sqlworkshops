# SQL Containers exercises showing volume storage and update/upgrade of containers

This is a set of exercies to learn more about storage volumes for containers and see how to update, rollback, and upgrade SQL Server using containers.

## Requirements

- Complete the exercises in the sqlcontainers folder in this Module.
- Make sure all scripts are executable by running the following command

    `chmod u+x *.sh`

## Looking at volume storage, updating, rolling back, and upgrading SQL containers

1. Let's update the sql2017cu10 container with the latest CU by running **step1_dockerupdate.sh**. This has to run a few upgrade scripts so takes a few minutes. While this is running, let's look at volume storage.

2. See details of the volumes used by the containers from the sqlcontainers exercise volumes by running **step2_inspectvols.sh**.

3. See what files are stored in the host folders used to provide volume storage by running **step3_volstorage.sh**.

4. Let's see if the container is updated by running **step4_dockerquery.sh**. If the query cannot run because script upgrades are still running use **execintodocker.sh** to see the status in the ERRORLOG file of the container.

5. If time permits, you can execute **step5_dockerrollback.sh** to go back to the SQL 2017 CU10 build of that container.

6. Upgrade the container to SQL Server 2019 preview by execute **step6_dockerupgrade.sh**.

7. Run **cleanup.sh** to stop and remove containers from this exercise. There is a cleanup.sh script in the **sqlcontainers** folder to cleanup containers created for that exercise.