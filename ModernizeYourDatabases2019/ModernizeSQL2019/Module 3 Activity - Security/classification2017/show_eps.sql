-- This query will show the classifications generated through a database's context-menu
-- Tasks -> Data Discovery and Classification -> Classify Data (SSMS 17)
-- Tasks -> Classify Data (SSMS 16)
SELECT *
FROM (SELECT EP.class,
             EP.class_desc,
             EP.major_id,
             EP.minor_id,
             Target.object_id,
             Target.schema_name,
             Target.major_name,
             Target.minor_name,
             EP.name,
             EP.value
      FROM sys.extended_properties EP
             LEFT JOIN (SELECT class       = 1,
                               major_id    = o.object_id,
                               major_name  = o.name,
                               minor_id    = 0,
                               minor_name  = CAST(NULL AS sysname),
                                             o.object_id,
                               schema_name = s.name
                        FROM sys.objects o
                               INNER JOIN sys.schemas s ON s.schema_id = o.schema_id
                        UNION ALL
                        SELECT class       = 1,
                               major_id    = o.object_id,
                               major_name  = o.name,
                               minor_id    = c.column_id,
                               minor_name  = c.name,
                                             o.object_id,
                               schema_name = s.name
                        FROM sys.objects o
                               INNER JOIN sys.schemas s ON s.schema_id = o.schema_id
                               INNER JOIN sys.columns c ON c.object_id = o.object_id) Target
                       ON Target.class = EP.class AND Target.major_id = EP.major_id
      WHERE EP.name IN ('sys_information_type_id', 'sys_information_type_name', 'sys_sensitivity_label_id',
                        'sys_sensitivity_label_name')) SQ
       PIVOT (MAX(value) FOR SQ.name IN ([sys_information_type_id], [sys_information_type_name], [sys_sensitivity_label_id], [sys_sensitivity_label_name])) AS PQ;
