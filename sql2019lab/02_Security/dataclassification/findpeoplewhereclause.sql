-- What if I reference a classified column in the WHERE clause only?
SELECT PreferredName FROM [Application].[People]
WHERE EmailAddress LIKE '%microsoft%'
GO
