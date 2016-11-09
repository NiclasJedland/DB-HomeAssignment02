CREATE PROCEDURE UpdateRegion (@RegionID int, @RegionDescription nchar(50))
AS
	
UPDATE [dbo].[Region]
     SET [RegionDescription] = @RegionDescription 
	 WHERE RegionID = @RegionID
