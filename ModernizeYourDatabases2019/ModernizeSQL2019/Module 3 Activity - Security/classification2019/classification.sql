USE WideWorldImporters;
GO

-- Set-up classification
ADD SENSITIVITY CLASSIFICATION TO
    Sales.SpecialDeals.DiscountAmount, Sales.SpecialDeals.DiscountPercentage, Sales.SpecialDeals.UnitPrice
WITH (LABEL='Highly Confidential', INFORMATION_TYPE='Financial');
GO

-- Show set classifications
SELECT SC.class,
       SC.class_desc,
       SC.major_id,
       SC.minor_id,
       Target.object_id,
       Target.schema_name,
       Target.major_name,
       Target.minor_name,
       SC.label,
       SC.label_id,
       SC.information_type,
       SC.information_type_id
FROM sys.sensitivity_classifications SC
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
                 ON Target.class = SC.class AND Target.major_id = SC.major_id AND Target.minor_id = SC.minor_id;
GO

-- Remove classification
DROP SENSITIVITY CLASSIFICATION FROM
    Sales.SpecialDeals.DiscountAmount, Sales.SpecialDeals.DiscountPercentage, Sales.SpecialDeals.UnitPrice);
GO