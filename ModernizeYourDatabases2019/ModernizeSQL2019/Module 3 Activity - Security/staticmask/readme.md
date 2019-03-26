# Static Data Masking with SQL Server

This demo is to show the Static Data Masking feature with SQL Server which is documented at https://docs.microsoft.com/en-us/sql/relational-databases/security/static-data-masking?view=sql-server-2017

## Requirements

- Install SQL Server Management Studio (SSMS) 18.0 Preview 6 or higher
- Install SQL Server 2019 (TODO: We are checking on whether this will work with previous versions)

## Demo Steps

1. Run the script **createhr.sql** to create the database and populate it with data.

2. In SSMS, right click on the HumanResources database and select Tasks/Mask Database (Preview)

3. In the dialog box that appears, select Load Config and choose the **hrmasking.xml** file provided.

4. Select the Configure options to see how the data will be masked.

5. Type in Step 3 the Masked Database name as HRMasked

6. Click OK. This will take a few minutes to run. The tool is taking a backup of the current database, restoring it, and modifying the data to be masked.

7. Compare the data in the original database to the new masked database.