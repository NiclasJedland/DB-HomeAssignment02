CREATE TABLE [dbo].[CategoryNameChanges] (
    [CategoryChangeID] INT        IDENTITY (1, 1) NOT NULL,
    [CategoryID]       INT        NOT NULL,
    [OldCategoryName]  NCHAR (15) NULL,
    [NewCategoryName]  NCHAR (15) NULL,
    CONSTRAINT [PK_CategoryNameChanges] PRIMARY KEY CLUSTERED ([CategoryChangeID] ASC)
);

