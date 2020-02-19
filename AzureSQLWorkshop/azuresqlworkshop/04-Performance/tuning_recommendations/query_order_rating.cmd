date /T
time /T
ostress.exe -Sbobazuresqlserver.database.windows.net -iquery_order_rating.sql -Uthewandog -dAdventureWorksAzureLT -P$cprsqlserver2019 -n25 -r100000 -q
date /T
time /T