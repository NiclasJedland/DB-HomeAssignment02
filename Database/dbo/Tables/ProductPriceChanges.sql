CREATE TABLE [dbo].[ProductPriceChanges] (
    [ProductPriceChangedID] INT      IDENTITY (1, 1) NOT NULL,
    [ProductID]             INT      NOT NULL,
    [OldPrice]              MONEY    NOT NULL,
    [NewPrice]              MONEY    NOT NULL,
    [ChangedDate]           DATETIME NOT NULL,
    [UserID]                INT      NOT NULL,
    CONSTRAINT [PK_ProductPriceChanges] PRIMARY KEY CLUSTERED ([ProductPriceChangedID] ASC)
);

