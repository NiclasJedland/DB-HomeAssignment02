CREATE PROCEDURE InsertRegion (@RegionID int, @RegionDescription nchar(50))
AS
	
INSERT INTO [dbo].[Region]
           ([RegionID]
           ,[RegionDescription])
     VALUES
           (@RegionID
           ,@RegionDescription)
