In order to run this exercise and the ones in sqlcontainerupdate you must first download the WideWorldImporters backup into this folder. You can do this by using the **pullwwi.sh** script.

1. Run **step1_dockerruncu10.sh** to start a container with SQL Server 2017 CU8. This container is called sql2017cu10

2. Run **step2_dockercopy.sh** to copy the WWI backyup into the container.

3. Run **step3_docker_restorewwi.sh** to restore the backup. This uses docker exec to **run sqlcmd inside the container**. Since this takes a few minutes it will run in the background using the -d paramater for docker exec.

4. Run **step4_dockerrun2.sh** to start another SQL container with the latest SQL 2017 update. This container is called sql2. Notice a different volume is used along with port 1402 instead of 1401.

5. Run **step5_containers.sh** to see both containers running. You now have two SQL Servers running on the same Linux machine using containers.

6. Run **step6_procs.sh** to see the process for the Linux host which include the docker daemon. Note the sqlservr processes as children underneath that process.

7. Run **step7_namespaces.sh** to see the different namespaces for the SQL Server containers

8. The restore should be finished from Step 3. Run **step8_dockerquery.sh** to run a query for the database by connecting **using sqlcmd outside of the container**.

9. Use docker exec to interact with the sql2017cu10 container through a shell by executing **step9_dockerexec.sh**. Notice the shell has the hostname used to run the container at the prompt.

- Run ps -axf to see the isolation of containers and that sqlservr is just about the only process running.

- Go look at the ERRORLOG file in /var/opt/mssql/log.

- Exit the shell inside the container by typing **exit**.

10. Leave all containers running as they will be used in the next set of exercises in the **sqlcontainerupdate** folder.
