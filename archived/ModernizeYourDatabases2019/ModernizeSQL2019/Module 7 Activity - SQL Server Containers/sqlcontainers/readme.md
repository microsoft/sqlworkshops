## SQL Server Containers Fundamentals

In this exercise you will be exploring the fundamentals for SQL Server containers. 

## Requirements

- These exercises were built to run using Docker for Linux on RedHat Enterprise Linux. However, you can review all the details of the scripts provided and use them with Docker for Windows or Docker for macOS.
- If using a RedHat Linux Server or VM and Docker is not installed, you can use these steps to install the Docker Community Edition for centOS

    `sudo yum install -y yum-utils device-mapper-persistent-data lvm2`

    `sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo`

    `sudo yum install http://mirror.centos.org/centos/7/extras/x86_64/Packages/pigz-2.3.3-1.el7.centos.x86_64.rpm`

    `sudo yum install docker-ce`

    Then make sure the Docker engine is running with these commands

    `sudo systemctl status docker`

    `sudo systemctl start docker`

- Make sure all scripts are executable by running the following command

    `chmod u+x *.sh`

- Restore the WideWorldImporters backup by using the **pullwwi.sh** script. This requires internet connectivity. You can also manually copy the backup into the current directory where you run the exercises.

## Learning the basics of SQL Server containers

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