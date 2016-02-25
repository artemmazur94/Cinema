USE [master]
GO
/****** Object:  Database [CinemaDatabase]    Script Date: 2/25/2016 7:45:54 PM ******/
CREATE DATABASE [CinemaDatabase]
 CONTAINMENT = NONE
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CinemaDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CinemaDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CinemaDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CinemaDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CinemaDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CinemaDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CinemaDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CinemaDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CinemaDatabase] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CinemaDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CinemaDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CinemaDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CinemaDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CinemaDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CinemaDatabase] SET RECOVERY FULL 
GO
ALTER DATABASE [CinemaDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [CinemaDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CinemaDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CinemaDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CinemaDatabase] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [CinemaDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CinemaDatabase', N'ON'
GO
USE [CinemaDatabase]
GO
/****** Object:  UserDefinedFunction [dbo].[AverageMovieRating]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AverageMovieRating] (@movieId int)
returns float
as
	begin
	return
		(select AVG(Rate) from Ratings where MovieId = @movieId)
	end


GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Accounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](128) NOT NULL,
	[Email] [varchar](128) NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[IsBlocked] [bit] NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Salt] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MovieId] [int] NOT NULL,
	[AccountId] [int] NOT NULL,
	[CommentText] [nvarchar](max) NOT NULL,
	[DateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GenreLocalization]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenreLocalization](
	[GenreId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[GenreId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Genres]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[Id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Halls]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Halls](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](128) NOT NULL,
	[HallPicture] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Languages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovieLocalization]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieLocalization](
	[MovieId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MoviePersonsJunction]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MoviePersonsJunction](
	[MovieId] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC,
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Movies]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Length] [int] NOT NULL,
	[GenreId] [int] NULL,
	[ReleaseDate] [datetime] NOT NULL,
	[DirectorId] [int] NULL,
	[Rating]  AS ([dbo].[AverageMovieRating]([Id])),
	[PhotoId] [int] NULL,
	[VideoLink] [varchar](max) NULL,
	[IsDeleted] [bit] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonLocalization]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonLocalization](
	[PersonId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Persons]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PhotoId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Photos]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Path] [nvarchar](max) NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[Filename] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Profiles]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profiles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Surname] [nvarchar](128) NOT NULL,
	[Phone] [varchar](15) NULL,
	[ImageData] [varbinary](max) NULL,
	[AccountId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ratings]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ratings](
	[Rate] [int] NOT NULL,
	[AccountId] [int] NOT NULL,
	[MovieId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC,
	[MovieId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Seances]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seances](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Price] [decimal](18, 0) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[HallId] [int] NOT NULL,
	[MovieId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sectors]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sectors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FromRow] [int] NOT NULL,
	[ToRow] [int] NOT NULL,
	[FromPlace] [int] NOT NULL,
	[ToPlace] [int] NOT NULL,
	[SectorTypeId] [int] NOT NULL,
	[HallId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SectorTypes]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SectorTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](8) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SecurityToken]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SecurityToken](
	[Id] [uniqueidentifier] NOT NULL,
	[AccountId] [int] NOT NULL,
	[ResetRequestDateTime] [datetime] NOT NULL,
	[IsUsed] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TicketPreOrders]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketPreOrders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Row] [int] NOT NULL,
	[Place] [int] NOT NULL,
	[AccountId] [int] NULL,
	[SeanceId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 2/25/2016 7:45:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Row] [int] NOT NULL,
	[Place] [int] NOT NULL,
	[SeanceId] [int] NOT NULL,
	[SaleDate] [datetime] NOT NULL,
	[AccountId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([Id], [Login], [Email], [IsAdmin], [IsBlocked], [Password], [Salt]) VALUES (10, N'artemmazur', N'artemmazur94@gmail.com', 0, 0, N'FFx+avlgR4G+1jOSwQm5AQ==', N'gXpX81cw0hURFjwG4/HXug==')
INSERT [dbo].[Accounts] ([Id], [Login], [Email], [IsAdmin], [IsBlocked], [Password], [Salt]) VALUES (11, N'artemmazur2', N'artemmazur294@gmail.com', 0, 0, N'zHcaSdIFkEIi6cIBiHEjnQ==', N'wz1iENGjZLEu2eCjYz7MYA==')
INSERT [dbo].[Accounts] ([Id], [Login], [Email], [IsAdmin], [IsBlocked], [Password], [Salt]) VALUES (12, N'artemmazur3', N'artemmazur943@gmail.com', 0, 0, N'46ZY7/q1Ap5xq8mXLox+jw==', N'cEdSe3eiFfxS1QttL/XVnw==')
SET IDENTITY_INSERT [dbo].[Accounts] OFF
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (1, 1, N'Drama', N'In the context of film, television, and radio, drama describes a genre of narrative fiction (or semi-fiction) intended to be more serious than humorous in tone, focusing on in-depth development of realistic characters who must deal with realistic emotional struggles. A drama is commonly considered the opposite of a comedy, but may also be considered separate from other works of some broad genre, such as a fantasy. To distinguish drama as a genre of fiction from the use of the same word to mean the general storytelling mode of live performance, the word drama is often included as part of a phrase to specify its meaning. For instance, in the sense of a television genre, more common specific terms are a drama show, drama series, or television drama in the United States; dramatic programming in the United Kingdom; or teledrama in Sri Lanka. In the sense of a film genre, the common term is a drama film.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (2, 1, N'Action', N'Action films usually include high energy, big-budget physical stunts and chases, possibly with rescues, battles, fights, escapes, destructive crises (floods, explosions, natural disasters, fires, etc.), non-stop motion, spectacular rhythm and pacing, and adventurous, often two-dimensional ''good-guy'' heroes (or recently, heroines) battling ''bad guys'' - all designed for pure audience escapism.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (5, 1, N'Adventure', N'Adventure films are usually exciting stories, with new experiences or exotic locales, very similar to or often paired with the action film genre. They can include traditional swashbucklers, serialized films, and historical spectacles (similar to the epics film genre), searches or expeditions for lost continents, "jungle" and "desert" epics, treasure hunts, disaster films, or searches for the unknown.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (6, 1, N'Comedy', N'Comedies are light-hearted plots consistently and deliberately designed to amuse and provoke laughter (with one-liners, jokes, etc.) by exaggerating the situation, the language, action, relationships and characters. This section describes various forms of comedy through cinematic history, including slapstick, screwball, spoofs and parodies, romantic comedies, black comedy (dark satirical comedy), and more.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (7, 1, N'Crime & Gangster', N'Crime (gangster) films are developed around the sinister actions of criminals or mobsters, particularly bankrobbers, underworld figures, or ruthless hoodlums who operate outside the law, stealing and murdering their way through life. Criminal and gangster films are often categorized as film noir or detective-mystery films - because of underlying similarities between these cinematic forms. This category includes a description of various ''serial killer'' films.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (8, 1, N'Epics / Historical', N'Epics include costume dramas, historical dramas, war films, medieval romps, or ''period pictures'' that often cover a large expanse of time set against a vast, panoramic backdrop. Epics often share elements of the elaborate adventure films genre. Epics take an historical or imagined event, mythic, legendary, or heroic figure, and add an extravagant setting and lavish costumes, accompanied by grandeur and spectacle, dramatic scope, high production values, and a sweeping musical score. Epics are often a more spectacular, lavish version of a biopic film.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (9, 1, N'Horror', N'Horror films are designed to frighten and to invoke our hidden worst fears, often in a terrifying, shocking finale, while captivating and entertaining us at the same time in a cathartic experience. Horror films feature a wide range of styles, from the earliest silent Nosferatu classic, to today''s CGI monsters and deranged humans. They are often combined with science fiction when the menace or monster is related to a corruption of technology, or when Earth is threatened by aliens. The fantasy and supernatural film genres are not usually synonymous with the horror genre.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (10, 1, N'Musicals / Dance', N'Musical/dance films are cinematic forms that emphasize full-scale scores or song and dance routines in a significant way (usually with a musical or dance performance integrated as part of the film narrative), or they are films that are centered on combinations of music, dance, song or choreography.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (11, 1, N'Science fiction', N'Sci-fi films are often quasi-scientific, visionary and imaginative - complete with heroes, aliens, distant planets, impossible quests, improbable settings, fantastic places, great dark and shadowy villains, futuristic technology, unknown and unknowable forces, and extraordinary monsters (''things or creatures from space''), either created by mad scientists or by nuclear havoc. They are sometimes an offshoot of fantasy films (or superhero films), or they share some similarities with action/adventure films.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (12, 1, N'War', N'War (and anti-war) films acknowledge the horror and heartbreak of war, letting the actual combat fighting (against nations or humankind) on land, sea, or in the air provide the primary plot or background for the action of the film. War films are often paired with other genres, such as action, adventure, drama, romance, comedy (black), suspense, and even epics and westerns, and they often take a denunciatory approach toward warfare.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (13, 1, N'Western', N'Westerns are the major defining genre of the American film industry - a eulogy to the early days of the expansive American frontier. They are one of the oldest, most enduring genres with very recognizable plots, elements, and characters (six-guns, horses, dusty towns and trails, cowboys, Indians, etc.).')
SET IDENTITY_INSERT [dbo].[Genres] ON 

INSERT [dbo].[Genres] ([Id]) VALUES (1)
INSERT [dbo].[Genres] ([Id]) VALUES (2)
INSERT [dbo].[Genres] ([Id]) VALUES (5)
INSERT [dbo].[Genres] ([Id]) VALUES (6)
INSERT [dbo].[Genres] ([Id]) VALUES (7)
INSERT [dbo].[Genres] ([Id]) VALUES (8)
INSERT [dbo].[Genres] ([Id]) VALUES (9)
INSERT [dbo].[Genres] ([Id]) VALUES (10)
INSERT [dbo].[Genres] ([Id]) VALUES (11)
INSERT [dbo].[Genres] ([Id]) VALUES (12)
INSERT [dbo].[Genres] ([Id]) VALUES (13)
SET IDENTITY_INSERT [dbo].[Genres] OFF
SET IDENTITY_INSERT [dbo].[Halls] ON 

INSERT [dbo].[Halls] ([Id], [Name], [HallPicture]) VALUES (1, N'Green', NULL)
INSERT [dbo].[Halls] ([Id], [Name], [HallPicture]) VALUES (2, N'Red', NULL)
SET IDENTITY_INSERT [dbo].[Halls] OFF
SET IDENTITY_INSERT [dbo].[Languages] ON 

INSERT [dbo].[Languages] ([Id], [LanguageCode]) VALUES (1, N'EN')
INSERT [dbo].[Languages] ([Id], [LanguageCode]) VALUES (2, N'RU')
INSERT [dbo].[Languages] ([Id], [LanguageCode]) VALUES (3, N'UK')
SET IDENTITY_INSERT [dbo].[Languages] OFF
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (6, 1, N'The Godfather', N'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (11, 1, N'q', N'q')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (14, 1, N'new', N'new')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (15, 1, N'new movie 2', N'new description')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (16, 1, N'moi film', N'moyo opisanie')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (17, 1, N't', N't')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (18, 1, N'm', N'm')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (19, 1, N'o', N'o')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (20, 1, N'5', N'5')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (21, 1, N'xomne', N'some')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (22, 1, N'my movie', N'my description')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (23, 1, N'some movie', N'no genre while adding')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (24, 1, N'Troy', N'An adaptation of Homer''s great epic, the film follows the assault on Troy by the united Greek forces and chronicles the fates of the men involved.')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (25, 1, N'The Great Gatsby', N'A writer and wall street trader, Nick, finds himself drawn to the past and lifestyle of his millionaire neighbor, Jay Gatsby.')
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (6, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (6, 9)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (11, 2)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (11, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (14, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (15, 2)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (15, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (16, 2)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (16, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (17, 2)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (17, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (19, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (24, 11)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (24, 12)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (25, 14)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (25, 15)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (25, 16)
SET IDENTITY_INSERT [dbo].[Movies] ON 

INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (6, 175, 1, CAST(N'1972-03-15 00:00:00.000' AS DateTime), 2, 10, N'https://www.youtube.com/embed/sY1S34973zA?rel=0', 0)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (11, 4, 1, CAST(N'2016-02-20 00:00:00.000' AS DateTime), 2, 20, NULL, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (14, 4, 1, CAST(N'2016-02-05 00:00:00.000' AS DateTime), 2, 23, NULL, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (15, 187, 1, CAST(N'2016-02-20 00:00:00.000' AS DateTime), 4, 31, NULL, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (16, 100, 1, CAST(N'2016-03-04 00:00:00.000' AS DateTime), 2, 26, N'https://www.youtube.com/embed/3Kze_J_BtxY?rel=0', 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (17, 2, 2, CAST(N'1999-10-10 00:00:00.000' AS DateTime), 4, 37, NULL, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (18, 1, 1, CAST(N'2011-01-01 00:00:00.000' AS DateTime), NULL, 39, NULL, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (19, 1, 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), NULL, 40, NULL, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (20, 5, 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), NULL, 41, NULL, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (21, 100, 1, CAST(N'2000-02-02 00:00:00.000' AS DateTime), NULL, 42, NULL, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (22, 15, NULL, CAST(N'1999-01-01 00:00:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (23, 30, NULL, CAST(N'1956-12-01 00:00:00.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (24, 162, 8, CAST(N'2004-05-14 00:00:00.000' AS DateTime), 10, 53, N'https://www.youtube.com/embed/Voai-4GS848', 0)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted]) VALUES (25, 142, 1, CAST(N'2013-05-01 00:00:00.000' AS DateTime), 13, 54, N'https://www.youtube.com/embed/sN183rJltNM', 0)
SET IDENTITY_INSERT [dbo].[Movies] OFF
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (2, 1, N'Francis Ford Coppola')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (4, 1, N'Marlon Brando')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (9, 1, N'Al Pacino')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (10, 1, N'Wolfgang Petersen')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (11, 1, N'Brad Pitt')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (12, 1, N'Eric Bana')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (13, 1, N'Baz Luhrmann')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (14, 1, N'Leonardo DiCaprio')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (15, 1, N'Tobey Maguire')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (16, 1, N'Carey Mulligan')
SET IDENTITY_INSERT [dbo].[Persons] ON 

INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (2, 43)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (4, 44)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (9, 45)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (10, 46)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (11, 47)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (12, 48)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (13, 49)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (14, 50)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (15, 51)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (16, 52)
SET IDENTITY_INSERT [dbo].[Persons] OFF
SET IDENTITY_INSERT [dbo].[Photos] ON 

INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (10, N'/uploadFiles/800fc71c-c4a7-4876-976f-159f740d4a28.jpg', N'800fc71c-c4a7-4876-976f-159f740d4a28', N'1972.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (20, N'/uploadFiles/6fd0e4c4-2a47-4580-8ffa-ceae371112f3.jpg', N'6fd0e4c4-2a47-4580-8ffa-ceae371112f3', N'Nikon-D810-Image-Sample-6.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (23, N'/uploadFiles/461d8c17-60ec-4c64-aec2-9e5047dcfe11.jpg', N'461d8c17-60ec-4c64-aec2-9e5047dcfe11', N'Nikon-D810-Image-Sample-6.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (26, N'/uploadFiles/c8100cc3-74fe-481e-81df-dc674b2669d4.jpg', N'c8100cc3-74fe-481e-81df-dc674b2669d4', N'southtyrol350698.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (31, N'/uploadFiles/f4e8cfdf-5ad2-4097-91fd-e46173f1fe04.jpg', N'f4e8cfdf-5ad2-4097-91fd-e46173f1fe04', N'southtyrol350698.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (37, N'/uploadFiles/f8468870-c363-40b1-90fe-20764f880a13.jpg', N'f8468870-c363-40b1-90fe-20764f880a13', N'Nikon-D810-Image-Sample-6.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (39, N'/uploadFiles/a00fea49-df78-4102-9c5f-8e6a0d944f3e.jpg', N'a00fea49-df78-4102-9c5f-8e6a0d944f3e', N'Robert_Downey_Jr_2014_Comic_Con_(cropped).jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (40, N'/uploadFiles/9629ccd8-9eae-4f91-bb8d-d20625d376da.jpg', N'9629ccd8-9eae-4f91-bb8d-d20625d376da', N'49e23d74c5bd677f_robertdowneyjr.xxxlarge_2.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (41, N'/uploadFiles/7c5ab7c4-f3bf-4991-b2e0-2e65596d0962.jpg', N'7c5ab7c4-f3bf-4991-b2e0-2e65596d0962', N'49e23d74c5bd677f_robertdowneyjr.xxxlarge_2.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (42, N'/uploadFiles/9bb45a2b-a50b-4ed4-827d-a991508b6e30.jpg', N'9bb45a2b-a50b-4ed4-827d-a991508b6e30', N'southtyrol350698.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (43, N'/uploadFiles/ca68b3d1-5de6-49af-bfd1-b29d5111cd90.jpg', N'ca68b3d1-5de6-49af-bfd1-b29d5111cd90', N'Francis-Ford-Coppola.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (44, N'/uploadFiles/35a70029-35c3-46ec-8177-d35a55d273e8.jpg', N'35a70029-35c3-46ec-8177-d35a55d273e8', N'Marlon_Brando.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (45, N'/uploadFiles/22b48771-23d8-4347-8b05-3cc7de8f5209.jpg', N'22b48771-23d8-4347-8b05-3cc7de8f5209', N'220px-Al_Pacino.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (46, N'/uploadFiles/52c3e8cf-6d23-471b-8781-055648295e12.jpg', N'52c3e8cf-6d23-471b-8781-055648295e12', N'Wolfgang_Petersen.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (47, N'/uploadFiles/44b8a4f7-fda7-41b8-9c04-ba92456ea5e1.jpg', N'44b8a4f7-fda7-41b8-9c04-ba92456ea5e1', N'Brad-Pitt.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (48, N'/uploadFiles/a965d315-3c4c-41d4-9415-01f153c43565.jpg', N'a965d315-3c4c-41d4-9415-01f153c43565', N'Eric_Bana_2014_WonderCon_(cropped).jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (49, N'/uploadFiles/b325cdb1-b811-4147-a100-b100429f28ac.jpg', N'b325cdb1-b811-4147-a100-b100429f28ac', N'220px-Baz_Luhrmann.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (50, N'/uploadFiles/78778e14-b93a-493d-a254-9ae0f119158f.jpg', N'78778e14-b93a-493d-a254-9ae0f119158f', N'422817_original-jpg.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (51, N'/uploadFiles/e076eedf-4f48-46c8-b0e2-6ad8a49d09c7.jpg', N'e076eedf-4f48-46c8-b0e2-6ad8a49d09c7', N'Tobey_Maguire_2014.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (52, N'/uploadFiles/7ca81df1-64f8-45a3-a578-0edb8415e644.jpg', N'7ca81df1-64f8-45a3-a578-0edb8415e644', N'220px-Carey_Mulligan_2,_2013.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (53, N'/uploadFiles/7a310bf5-a8aa-4eef-b954-daca0f2064b9.jpg', N'7a310bf5-a8aa-4eef-b954-daca0f2064b9', N'defa55086d1d29228b0290b71a07486d.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (54, N'/uploadFiles/453cb555-77ee-4275-a772-313d76c6c57a.jpg', N'453cb555-77ee-4275-a772-313d76c6c57a', N'a-great-gatsby.jpg')
SET IDENTITY_INSERT [dbo].[Photos] OFF
SET IDENTITY_INSERT [dbo].[Profiles] ON 

INSERT [dbo].[Profiles] ([Id], [Name], [Surname], [Phone], [ImageData], [AccountId]) VALUES (1, N'Artem', N'Mazur', N'8888888888', 0xFFD8FFE000104A46494600010101006400640000FFDB0043000503040404030504040405050506070C08070707070F0B0B090C110F1212110F111113161C1713141A1511111821181A1D1D1F1F1F13172224221E241C1E1F1EFFDB0043010505050706070E08080E1E1411141E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1EFFC00011080190012C03011100021101031101FFC4001D000000070101010000000000000000000001020304050607080009FFC4004710000201030204040305060404050305010102030004110521061231410713516122718108143291B12342A1C1D1F0155262E1163372F124435382927383B20917264463C2FFC4001A010101010101010100000000000000000000010203040506FFC400311101010002020202010303020602030000000102110321123104415113223214617105812342A1B1D1F015E12491C1FFDA000C03010002110311003F00D0E343D2B3B5A731C781510BC69ED55A2E91ED510B2AD542A8940B2263B540AAAD5D051577DE80E1681554CEF53614029A0755AA0DCA46C3A9A042EB51B1B38C3DDDCA4593CB8C1639F4C0EF4DAE94FE29F187C3DE1891ADF52D5E696F63244B676D6CF24B0018F8A5C0C46371B93FA54D9E35549FED1DC211980C96371E5CCA5F920992E2445CE399D622C573E870477036A8BE295BCFB42F85F656F2BDE6AFA8DBCD14224FBBBE97324B213D1503A807B6E7037F4AA9E2CB78DBED6BCD1B41C2BC3B6E0AE184B7B23BA939E85542E703A8C8193DC0DEEAAF4B1784DF6A2B3D6AE869BC79A141A1B12A916A365E63DB8763F089509668D4E47C439BAEF8A7A4D7E1BC6A7C51C37A5BCB1DE6B765E640A1A758E50FE529E85C8D941C8C7311D69B3550FA5789FE1FEAD7ABA7D8F13DB7DE9CB0459E37881C75219805236EB9C1A9B8BE357531B2A838CA900AB0DC11D88355937BE1FB107DE816B400DB2E37AA83F2536AF72554084A0F720A800AD500577E9405E5A200AD14529ED4052B4411928A4DA3F6A027967DA82811A561B3844F6A2178D281644AA7D9644CD4DA1645C5205157DAA83AAD02AA94D8502D40755ABA0A2AFA5079B646C1C103340DAE6436B70ACAC4A3FC003364799D57F3C11F31515CF3E2478897779A1CD1E8FAA1D36CDA39A696E415F31E052E0B8DF980675E55E5C17208CF2A9CC6B5A62BC1D657B7A1D9AEEE23B1BE712DEEA5273870DC9CD2AC2B9E8010864EAD90AB80C6ADE89DD5B75CBCF0E784F4813F0C694E7548949B09DE564914E00324CEA71232E0E635014160B97239AA6F6B26BDB15D52EF53D5EFA4D4F52B8B9BEBB9E4C092562EEEDE83F4AB3F0CDB6F6B1DBF01DCC3A8AD9DC5CC42E2004EA27939A3B57DB11673F1C9D987E1539049C1C36687E2ABCD18AA59F0F691C90448C8F79712069AE72370D8015507EE8403619268B668DF85B4FB5D66E6DA2E2AD52F61D260FD94305B72F316C7607E11EE772718F937A356B59FF807C237D26DB4CE1FB0D4388B5CBA4CA7FE31E0311396FDB11CC233B10B12A3C8C33F317C93C75ED15A2F187167851A845A0C1E22DE3D985E76B0B3B81345A79E6C796FE623818001C28C9EE149359DB5275DB42D0BED6491DB358F136827599237C457FA681079C3D5E27C60FCB19F4157B66C8D9FC28F1878178EE58ECB4ED5A6B1D465004361A95BFDD9E66EEB1312564618FC2AD9EA715A952C694C855B958608EA0D10070182FEF1ED403CB447B96A8F72D0072FA50011ED510057DAAA8A545014A510D67B98216025902E7619A29BC9A8D9AF36665F84EFBD037B8D66C227E56932719D8D054634CF6AC34728BED40B22D50AAA0A9B42CAB421455AA528AA3B5028A9BF4A9B0A80290180AA0E05018ECA4D004386D97704EEDDAA0CE3C62D78E8BC1B2C892B35C4F2968179B9492A4A8231E9871FFC8ED8A8D63EDC83C4FC496D070E270CD9069E190A1BD9988F8D5482225C7451C88060EC01C7E2348D58A8EABAD6A77E638E7BB9BCA8D55638D0E02AAA8503E4001485FC1805420B349F88EEC77C0A268FF4EBC9B47BC82F926686EA07125BF2FF00CC471D1B1D883BF63D2AFB3A9ED2D7BACF126A5636B6B2DBC915ADB232853F03485896676CFC4CC7272C73D4FAD4E9AEEFA8671ADF400B29504804F36E3FDE868C56478A60C7959D4E72A4641F5F9D1274B369FC5D7DC3FA53DB70EDD3D9CF7D195BBB82804A84FE2F2D86EA186323DBA9A2D57B4F86DA7598CABCEE0641663863EE7AFEB467DA7F46BBD3F48B78C4FC2DA3EA33ADDACA1E50EE59072E50F3301CA7DC7AD36BE2B2F11F895A76AB08D357C2DE1CD1ED240BCFFE17335BDCC92291E5B1933CA3077FC1F9751769AD349F097C7CF15ADDB46E1FD5345B6E22B5B99859C17FA84AD673C921C9489EE9FF0066CE546173BB6DB93552C75B70FDC6A177A5413EA7A3B68F76E80CD64F3091E16EEA587C2DFF0050241EB559A91C554011440E28AF72D41EE5A002B4052B4052B55145E2A8352935A88593A120EE8C7A8F954691F2C167F7C06EA09ADB6C380C4A9340E60D3ADE3882A4B15C2FEEBB1C9C7A5509A2D61A2C8B442C8940B22D0D1455A21445068A5556A20E0550702A836280E06280929CBAC43959CFC4179B7207B7A5032B8D452D223CB9566384E520B393E83DBF956574E5DFB48F1419BC8D1E2BB8CCD6F713C7398B2A91C7F87073D7BF6DB27D4D4B5D319D6D805FDB18AE39A760A5D15D7B7C2DB8DBB6DBFE554CAF649E5B58DB963B7699B932C5CE006EDB7F79AACECE9608C451B865595221828BCDBFAFCC9C81EC2A282D654B66F3235C3F2925D7F18FFDDDBE94BDACB21D5B4D717665668A59CE3124AB27C08BE85CF4FEFAD4F44B6FA25A9EA9CCEAB0B4A028214F9E580F9600ED8ED54DA19BF6F203F1C8C761B9AACFB143FEE2CCC57BFC58A68D97B6E7478DA2556C1CF5EFF2E94A692CD2F9F68591924B918188F2C17AF563B0FCAA6977A442BBF9A31CD93F0B72AF623DEAE937B3CD3AEB5686CEEA1812E65B3728B3A2890C2C41F8323A039CF29FCA88E9DF0E7ED4FC449A7C5A0F14F09DA3EA1691246B7E656879D557A3A3B01CE54641E7507738ABBD1ADB7AF077C4BD07C48D3E5BAD32E658AF220CCF652801847CD8590606083D36271D32692A58BEE2B481C5447B141EE5A00C50072D0015A228FC6315BFF8CDBBCB3BC041FC433F96D51A29711CA5C379D1DD2E3A361BFA1AA1A3DB46CC49B65FE3542082B0A5D16A05956A85546281455DE81455F6A885003E9407507D2A8360FA507B948DF9BF3A066755B55BFB8D3C96FBD5BF21298FC6ACB90CBEA0743E8719EA3219678D9E224FC2FC366E7446B4B9E239E44688221916D232FE50661DF25B94038CB67D2A352324B3F18B88F4CD42E609DA3D5EE9229512EEE1446C980490AABB2E173B7620F5C8A8DF8CD325E2AD5D2FFCDD4E691A4924766C331CBB67259BD7738FA62922E596BA8AEEAB3F977C924922CF32C6AD221521524C6C9EFCA3973EF915BD39938645160D1AAB34D33F348D9C92BD80F4C9C927FE91D8E652168D25C62EEE3C98CB06112FC59DB00E06D903619E94FF000B3FB9E85879916CE35E52321A66E6763DD8EF85C7C89EB517D9ED8049CC704B7A8133B2CA0A4683D4A8DCF5F99C566F4DC9BF626BD069D6F32C1677D05CFC258BC430A074E9D89F73564B7DB36C88B834AB9B9B36D424FD95986F2CC8DB2F31CE141EE763D33DFD2B5D467BA44D9428A648A2661FBBCDD4FE5D69B340B98EE6D64559A0F2DC8C84207301F2EA3EB52C257A39A68DCF2C6D19FDE2AA36F9D2C594AFDEDBCDE7953CC650402005DFDE8A3C57D1FDD5D637B88A5E756431CB8E5208393F2C76EE6AB3BD92F22EE69103DC966B87C7EDA5E507DCBB90BEBD4D0593C39E3AD778038E34CE23B499E77D35C2CB6ED3F32CB6E7678B6382A54EDD81008E94371F4BF4ABFB2D5B4BB2D574B984D617D025CDBC808398DD430391F31558BD1E015768F0514038A141CB9A800AFA55005688A7F16C3FF8E86428AE037427181EB4689F971B005A10A7D41A81BB200C42E40FFA8D687353FDA3ED14E16D25FF00E15CFB6B516CF0B7C611C67AE3D8450C9198C02432E320D12C8DAD06C0D50A28A2AADE26F10CFC35C3D36A10A962885B0BD76A6D276E7E3F68CD5D972B6337D5C54EDAD422FF00687D78AFC364E3E728A1E249FED03C4ACB916A07FF007686A1ACBE3DF15B60476D1F31E9CD29C50D1B4BE3B71863E336C477F2CB647D326A2C9B46CFE27F12DC6A0359466172A7FE60EBC857959704F4C0538F55146BC618B6BB73A8699AA8BDE79A4BC688F331C8014923049DB04E462B32AD883E33D5ADEF26B6BEB788453CD6816F53231E701CAEC31D0372838F9FAD6A26F4A94F74E5F2581C63E1C6DD4100FAF6DAB51CED372A24024672C4925F23AB127F3F5FAD6BD20DE7156D87BE3B7D454D2816525831393EF442892B2A925CA83B951D001FCEA2EC93CF2BF4380C76AD489B4869D045CE25BA7F323E61C9181CCD337618F4F73FED52DFC2C9F752AD7D6ACCB25DAFDE5E31CA906E114FF936F964E31FCAB3A6B61B996E2FAD67BD99D2D63C9711C78418FA741D4051D7DEAA2BEF3967C448A727A9DBF87535749B2D71692D9A869444AE7A232156C7D77A0416720F2E14E4E4823F9D4B1652E6381D448A0737EF6363F31EBDAA6EAD93D9782E920864428CF9C142AFCBC8D9D9BD09EBD7D6AFB67D1CB5C44EB05BDF3C971004E6898155651BECA47439EA0EDD71D68AED0FB0DEA721F0A6FB4C953CA820D55DED17CD2E15191399413D07302D8FF51A4A994F4E87420A822AB23605348F6283D8A695EC0A002288A9F14C61EF6342EE809C7329C636EF56AA3ACE0B909CAD76EE98D8641C540AFDDF7EC7E677FD2B495F330EE6B2DB5CFB2CC9CBC793AFAC4A7F8D4476920CA8F9502AA2A2A83E3C4624E07BA047FE5B7E9548E1919C6D45F4119236A0532718A2985CDD4A66748CE1576C8EA6A44B498B8B887045CA31FF002E28BBB0E2DAFE74E8B18DBA1D87EB4B17690B59E4FB9CABCBCA25390036D8F4C54D35B43DFCC4CCDF10C6318AB18B4C0B123946C49C9ADC606CFC21463DAA2BC09C1047C4DFA7A5541D403CC7B0E99FCCFE95004992397037393FD290AF2F22B8E6C9551B0F53E95685D2E5932D801F979463F5FF006A813B79312866DC0EA09EBEB9F6F5A286EEEE4BAF8413B90001DC76DAAC9A4B7698D1E0874E984D3CD124CA0E4B2090A646DC83A16F7EDDB7E92D59D1E5D43A43DAED1CE6E98738F35F00E46031C75C9DF03F8D45EA20E4B467BA685159A40DCA542F43E9B7C8FE46AA1103932A1B2A0ECDD454583F45085727241F95004170D13004EC0F5C0DFF00AD12344F08B8FB56F0CF8960D6AD099F49BA75B7BD84B61644C8247B30EA0FB1A7B5D3E8CE8D7B15DDB24B0C81E3750CAC0F504641FCAAB162445201028068071440114156E2A8D0DF41CCC5496C640D87CFDAAA9969F13437124642F21FC2ABD8540E9ECD1D8B72039EE4D51F2F6A34D4BECCB2F2788DCBFE683F9D4A8EDD8778D7E42A0556A0A5F8CF1F99C17743AFECDBF4AAB1C18DF0B301D98FEB54AB0F87BA243C43C4F6FA5CF2944901270704FB543D4597C5AE009383EE2DA6B62ED6938DF98E790FCE9565DB2390932382C42E7703A9AD251E156761E5C27AE3A54A4FEC978605485A59E0712A8F8542FA7AFB546CCEE2E9DA328A39573CCBCBDBE5574CECC5DCB9DFB6D91DC513D881086DC0DEAA683CBBE4907145D0554F396233BED536BA291823B6DD4D2D343F92FCACE4647A1A9B5D122A4E480723A7CEAED342729E4E9D4E2AECD042B905141F881CE3F3A4A9A296E3C90D381938013D8FAD2DD80F39D5B6EDB0A215B091CDDC6DBBBF38C27372F31CFAD50EA2BD48DA485230412718246492339F60077F7F5DA28D74995C94658998F94C54FC5DB217AE3FDA87B36932857279940C02075F7A812CE08CA8CD048D8CD03D97DC2F7CCF2A49D1CE1F6C0C827E7BD4BF98D637AD577FF80FAC41270E69FA7DB48CD6F6D6D1C30F3373128AA02E4F7DB1538F2DC3931D56C0872A2B6E630A03628040A00C51155E33F316585A30BB38CE7B8AA18413996619010E70467008EC45454DC702841839141F2B4D15A47D9C9C2F89700FF34247F1152FB1DCB6E7F6287FD228175152AAA9E2C273F075D0FF00437E94FA1C0B7200B8954769187F1ABF453AD16FE7D2B52B6D4AD98ACB6EE1863B8EE29A236CF1BF8C2C750F0834CBD8429BAD52410090AE7915006723D0EE07D454F64E9CE302C3E696B8E6298C819DCFCCD6912B64D098D95618D5339F8D8FE781FD6B35B81BB63E62C4034CC0E1117A7CF1FD71490B69835B5C125DB651F887A7CCF4AD6E33AA41A375393FAD4DAC8710DBB4A7970D9E5C28F5E952D6A63B2BF76C00307989DFFA567C9BF03CB7D35DF91D46C1B07D8F4DEB37923738A9FDBE8139860B8585A442595D403904763FDF7158BCDDBA4F8E9DD4384658CA4B6F11F22484B29F6E4C81F3C03F95719CFF00976FE9B6AEDAE8931B596E0A0E48A59237C8E87703FBF635DFF56387E85368F4B964905BA2E64FDA91B7E2E507A7E55BF38E778A94D3F4F78F53B67628236232CFF8517D4FB0CE7E552E7347E95D9ADDD84B196888CF2485718EA77AD4CE566F1D86C9612B1271D0E307D7D2AF9467C283CA96DCE4021B1B1C74CED577B66E3A231C614A91D73BE6AED347EB729E62ACAE1D1492FBEDFC3AFCA9A0BCD259CBFB483EF3705532D24B181CA7A050076EFF004A68B48C36CF7598D60649707766F2C1C75D8FB7BD2F449B36BD865B49DADE4F2E423A8570C3E84120D588DDFECA3E224BA5F125BF0DEA773CD05CE16CA4727E17DFF664FBEF8CF7047715CF5E396E37BF2C755DCFA65CACF6EA73938E82BA391F8A030E940341EC505638D622E22C27361C7D29B11CB61E5C627049C6720F4140BC37EF1C4AAAC19719183D3DAB43E5E93595DAFF00E00BF2789B63FEA461FA541DDF66736D19FF0048A070BD2B2AAE78949CFC27743FD27F4AA3E7FEA239350B95C631338FE354FB24A4D543BD535E66E0F6E1A9A369956E56E20627FE41C10DF983D2A4F6D5565490C323247503D2B5A64FA05BC750D146B1027031B9FA67F5A9D2F67315BC83E1375E64C49CAE491D37248359686B91E54211EED4BB7EE460FE47D7F4F7A28B6568EE07E2E53D72D8FD2B1965A74C30B92D961A05AF94A59CA4A46543751E849AF265CD5EFC3826964B0E1593EEFE5BA47248E064249D3D1877C7A8AE197357A30E08B3E9BC30AB0AC3E4FEDC8C12A39838FA76C7AD71BCAED870459349E17FB8DC733F34D1C9F8A32A06F8F9E3BF6F7AE7972EFDBACE08939747823887247F840CAA8C30E504039E99C13F3ACFEA6D7F475151BFE1B4864BEBD86DD61B6BCC19236E8718C9C0E9B8CEDEBEDBF7C797D6DCB2E1D891F07C07C836C81BCA9BCD8DA3C1C03F8909F63D0F7AD5E6739F1E520FC1616ED6D869BCD089FCF5E5504A263E2E5FF32F6E5F953F5F497E3C29ABF056972332190B995DBCB2A4F3202318C7A80A2ACE7A9FD2EFE91B2704450DE7DF2DAD79A19140E56254C7229C6D9EA0ECC3DB35AFD7E99FE9F5553E21E139FEFD3F931C6C1198B18CE467D06FD3DEBAE1CF2472CFE35BE953BDD0674462C8C922FE38DBA8AF4E3CD2BC99FC7B107344E8083D8E318AEF2BCB71D3D119563F297F0BB65B27F111D3F2C9FCEAED8D2762CB597DDDA4E45703CA50A00CFF009B23BD46A4A8ABEB45B69D8B9C64EFB77FA7EB5529D68F72965AAD9DE4124CB3433C530E56C67964538C8E876C83ED4B3A27576FA4DE156B96BABE890DCDBCEB24722F32B061B83531BB899CD55E85699185008A011415DE31204485890030E9F3A0F655F492AC411FC4551002C3289CB8231E9547CCF9F95A67641852C481ED9ACAAE5E08C9E5F897A59F5E614A3BE34FDECE23FE91503907B565505C7E9CDC2F743FD27F4AA8F9FDAE80358BD5C63170FF00AD55BECD573DC5511F7E8A92B331259CFC3EC290A6B16CFF0000E66ED91D2AA154C91F0B16627E2C6C31EE6A07965173B840412412130483EBB7F5A95A87B0C724E3EE9046793CC2647182D21F9F6007615CF2CB5DBAE38EEF4D038674316F6C6E6EA28D3032100C9FAFAD7CFE5E5DDD47D6E0E0EB7570D36DE32A8F200A49C9DBAFB7BD78F2CDED9C6B4699CCE85515416DB9428E9E95CAD7698491310AB28CE536EA53B7CFD6B376D630E2366039D406CEE33DEB1B75937D1C24DC8DB60B0EC2ACADCC370BDA488AA23F21B61EC7E9565D3196235BDBC36E7CC48115C8C1271EFF00C29B67C42CE9CE59E3CB0D948DB947B537A3C08DC725C216641CC0FC3B753EBEC69E54FD38653EF0AE7E31DD5973F4AD6D9B82BD7F6B144D948C01BAE30063D87B56B1CDCEE12AB57BA558CB3BF990AA3B11865FC4090DB83FDED9AED8F2570CF8FB673C67C332DAB3DCF92BC848CB003F957BF879B7D3E6FC8E0D5DA932196170AA08E4E9F1135ED976F9D94D54CD85FB5D69B35ABABC72C4BCC0C72019DC6E73F11FCE9A37D20EF3EF0B2159D8963B90DBE6B518A77A688E499514794EC769146715163B8FECC9AD7FFC434DB4E7C98A11130740AC0AE413B7506A4BD99C6F70B975041047B0ADB9951D2804502371750C3F8DB7F4A086D4E587506085495045360CF12471858C6149DE81B18645C01CE0636DAA8F9698DAA34B67842793C46D21BFFF00423F8511DF9A49CE9F09C7EE8ACD0F97D6A2A1F8CD79B872E87FA4FE9551F3F78A23F2F88F505C74B97FD6ACF4B4D635E71E9550D358B61E52CCA06C3949A91AB10F86E83F856993F55305BC40C62479FF000AF4C8ED8F6F7EF53ED523A3DB952F207569475457039BD00F5FA6D58CABA638ACFC3B642378E59255C99065148C7A91EF5E5E5C9ECE1C57CB72668C003E027183E95F372BDBECF163D25AD722418DC000015C6BD326D67D2D9445F0B0CE704D665917C7B49439918144EBD4D4B93A49A8710AB39C236E3AE4F4AE76B7268EE1839C85277C1C80719A453B580A2051CC413D00A766A0AD0F4D9B03B9C9A7766D7FB129A3EA3603037CD2A486AE8CC4B6EB9DB73FCA8D5C6435911C1CA13BFE2C8D89FEB576E771456A51E799402580C83D2B518B8A1DD33705DC00C14003D704FF005AE9BE9CB2861AEDBDBC8BE548C50499CEDB118AEBC595DBCBCF87ED641C4FA33DADC3CB12891909F84E1B9977D881DF15F578B3DF4F8DCDC7AECDA29258ACA1B8B5B68AEA30BCDCDC996888EAA7BE0F4C57A23CD9457EF264924E6405189DD0F407DAB51CED2964C1E45424AB0DC60E3069495D05E00F1649A65D25ACD373290B801B3920E0B0C7AE57AFA572CAF8DDBA633CB1B1D97C25A925F58A48AD9C815D65DB8D4F839AA8F1E941117D6E6694F36481DBB54074802478000AA149114C1862A08EB40D524880C33A8236EBD6AE870327809C58C066E601FF00DB359DAAC3C0DE09711691C4FA7EA57177194B7939982C677DBE741D59A5C6D1D9451B7E255C540F074A8A67AE5AB5E69735BA1C1718AA39C355FB3BDC6A1ABDD5E9D4AE104F297E50A36CD589B1EDBECE1C9FF3352BA23AF6FE943661C79F67ABAB5E09BFBAD20DCDE5F448B24700393210464018F427F2A6C8E64B8824B59E482E63649A2731C88DD981C11F98AD0F0679673248DCCCDD49A87B58346279C2A938F5E5E95CB3BA8F471CDDD2FB672A35BB46B0804A80318FCF35E1CEBE8F1E3F4B269C3F628076FCABC19FB7D6E39D272C2020A9241C9C9C571CABBC9D272D10AB80BDCEF58DBAE3DC4E59C4FCACEB190A47A64D46BEBB48DAC2AC80342EC4EE4919F61B7F7DA93B67D5F694B5D3E57018057C1C0C29DCFA6315B985AC5E490EA3B2B92842A920ED900ED5661954B9E2235998833BCAB9C80EB920FCF9454F1B3ED667BF50DEF2D914F365986E724633B77A9719EE3732A8FBA40A18F9671DB3FA566B73B3075270FCA060FAD42C465E44ADCC3A9EB835A8C652E90F750B860EB8246E47A8AE92B865D23F5B88CB68AD1938072338D8D6F8AEAB972FA53F8BB4FF00BC69C649125251430980CF95E99C7E119F5C0E9BD7BF8F2D57CAE4C76A46996329B891972937E1F81B97CC3D79948E8C31D31F2AF76396DF3F2C74AE6B72CF7172E6E9144C5B24950A5BB6E06D9DBA8EF5DA3CF4C210C1F18CFB1D88AACAEFC217F3698B1EA72C02010392643B994360728FC8573E49B9A8EBC596AEDDB5F67CE211ADF0F473C6C7941E5E9B838DC7F7EB538AEE272E3AC977E21E32B5D16E5619E45CB74056BB69C914DE26D8E3201C7B2D349B445DF88134F396B484B29DB98EC3F2ABA0CA6E2FD666BBF2A3E5EC7941C9AB6076359D708C88C951D763914D0059F5C90798A1806DF6A6A09AE55FF281F4AE6D0CAA3D07E5452AB802B20C280CB4071B5690246410681A6AB147259CA9212519482A4E03FB66A2BE73F8A7C353709F1BEA3A3CEE5CA3F9B1E7AF2BFC401F700EF571AB94ED5B8D827B9F6AACA7787A72B70A521E83AE09DFD6B872FA7AB86F6D02C19E7573B2B730F842919F7AF0723E9F145934743345E512460F6EF5E2E4BA7D3E2F4B4DAC785186383D3DBDAB8DAEF2262CD088D7723D89AC6F6EB349CB2FC2D962472E48FAD485BA4D68D6E269C445B21B27AE7B6DB77CD76C31DF4E7C996A6D2F25B40B0F9418F3F2904862492477ADD935A73C72CB7B2B15B2F288F04F2EC33F11CE3D6A68B9056121C91B052324ED8F714989E509DEC36823F31A48C83D017D89CF71DBF8F6AB663ADAE172B748CD4E1454063C0661CA541040DB3918EDFEF5CF3927A75C2DFB415D2B0206F93D4FAD7274FA47C8AAD9E66DCEC08A6D9CBFB226F17B67E75B8E566D117C19584641E566C730EC2BAE15E7CFD2B9AE858728AD19E56279B072A00E847A1CF7DBE55EDE3EDF3F9659DB3CD7E4B68E1C88D629D1DB993E2E47538D83038CF5383B8CF535EEE37CEE555B586492E44C798F9832C0F507DFDEBD11E5C9EB356881764E718DB207EBDAAED9D256166B991431E5500128371B74F9E6B36EA358C75B7D95EE069BA4AD84974B712BBB4D2380547339C9001F4D87D2B9F1652FA74E7C6CF6B678988D7BC4B67028044808FD2BD31E5AB0A685A469BA320BA58F9E4C0F8BA93413363A4E956BA744FE4AE18ED95ED501ECF8774E8F5B17822501C6F5762564B4B50E59221CA41A9B06D3D21FBBFF00CB1D4F6AA2B00561B1D6A50715018501C5018107BD6808F7A212BB5592090310630A4B63AE31B91EF52ABE73F8CF7725DF8A1AE33962B1DC9890375551D8FBFAFBF4DB15709D2E777551EF927F2AA897D125749472955DF049193FC6B9724E9E8E1BDB4AE1F6E60A8EF973D177249C7E4057CDE57D6E1FC2DBA042D1DCB3312727619D866BC5C9E9F478D6BB550B90A41C124E7F9570AF5633A3EB7D9F9BAFA839C567DB72749BB0C150773F09D87F2AD489533A646A034EE3F1304523AA81D47FDABAE38F5B72CADDEA259210194AF99D4901188C7BE7FDAAF8C637D161046098E492E4851CB832B1D81F407A5353ECDFE0711C31B3B3451844DD4919DC9DC629A9B25B7A213C699522045DB0CAA30C33D3F4C7E557C5A97FBA2B5668829432B7999EE300E40393FDF4AE79EBD3AE1BF6879A58FC9380329D3B730AE5BEB4DEAA3DD79897C8C01B8CF6A9B5BAD236E631F11C8E5F9D6E38E4879E27791F2361D302BACE9C739103AC19998B8B5694670CC881D940EA71D71EDD36ED5E9E2C9E1E5C7A675C511AE654B8B697EF0E73CCAA14E4F4CAE3A7D6BE8F0DBB7CCE7934A55F46E8AAADE67282400E00C7F1DABD51E1C925A12A3DABF9B3A46A843264673D3233DB6DFE94C931F6B3D85B2AABCE073B2C839C8C038C67B74AF0F2E5969EFE2C71DB51F03F5D6D3F5748D9B94134E0CB5747C9C7736DD60B98F54E2CB17E60DCAA48FE15F465E9F32C5BF5FD186AF796F133B058579C007BD04EDB599934F585B04C58C668852D583CD2A49B08D76F7A0573122A7C63973B9A2885E2B77648E41CA4E6AE91408757596DA061B338CE2B9B6F6B373791450BC01BE3F4ED412BA6995ED91E5041233BD4096B66E12D19E0C923A60D508584972BA53CB29C32EC4E6811D12E24B89DD998ECD8A077792CF73782DE13DF0067F8D10A436F79089033672840C1D8E45070278FFA63E99E2BEB0AF2891AEE4FBE77F8449B85DFDBF5AB8FA5AA111939AD2257420C2518E607D546E0571E4F4F4F07B6A1C2BCA790C4003C9BE5F9988F9F6AF95CDF6FB5C1175B34FC32804027D6BC76BDF8CD2C162FFB11D093DFA9AE793B43A6E72EA157941FEF158D3AE35256724F948D410D8EB9EDF2ABD975ED63B797974F85648A750096C2A93D719F6CD75EFC7B729DE574776172ECE14C4EE06E015E538ED927DAAE35329AFB488795CA9458E307762589DBFB153B63A16481BEF4C5A7958B00DF00C03B6DB676C0C7F1A59DF7565EBD11991559BCC334C5B77E724839C75DFBFF0023D29646A7F644EAD122C71AA2F968BF8571CB8F4FD6B19FA74C6DDA32E57CE95A4E55E60394E3B8C5677BADFA9A323146C8194F2B0CE413B9159E8B9547DC00AB8507EBBD6E473CEECC84243E180393915D1C7E91B7F66ACAE7E25241FC046C7B1DC1AE98DD38678ED9C71CC935A012F37DE54310619BE07C63B15C13F4AFA3F1FBAF93F266999DDCF25D484333B8E638E7392A3D335F423E5DECF6C921169CAF6E6566D94962027BEDD7E5434B469EC65D1D6575113897CBE4F5006739EE77AF1FCA9AD3DDF172DEE26F85AE25B6D4A278C9CE6BCD85D57A339B8DEFC2BBE9EE38AED4484F2F21EB5F570FE2F91C9D64DC5E39D75E47C11118BAFBED5B6217BED521B38A60255041F5A6841DF713C4AA16220BB2F29C773574847EF17B25A2AE794633907BD5D26C55965619691C91B56B49B56AF74BBA82E6CCC1F8133F97A57074582FA2792CED82AEE3AD2891B3045B203D40A8A2EA0864B4745EA6AF4108A07FF0B962232C6888ED122782E1D597039B236A07D7904F05D0B9807B8A052D1EF6E662651CABDB1B62838ABED77A5DC58F8D37F2BA32C3750C260D88015635040F6A4FB6AFA8C7DF25B61B0AD22C1C27666E26CF310A0E303BD79F9F2D47B3E261E55A8E850470222228561D4FAD7CAE4B6BEEF0E122D5037240D92013D39BD2BCD66DEB897D3118945041D8363D2B15AFA4B247E62F3633CA76ACB532D25F4A552C0F26795BA636F5AB16D59D4423954E39977196DBE78AEBD394D948C018601C9200040C9071B7B0A6CA7114CAB708BD19DBF776CED527B4B8F442E669249255570AFCE41C8071EFBFF0ACDB6D6F1C4416F7533B09A76718C919C7E98AB25FCA5B2186A162BCAA16350C464EDED58CB1D3A6396D1D2C51B5B124659763B567AD37BD533FBBC21795085C0FC2452473B9541EA3CCAE546CC3D7A56F14CABC1D428C905B724D69CA985D746EFE95D318E59D673E28C45F4B2830AC3F0861B11E9ED5EFF8D755F33E5CDE2C8E20DCFCCA3BE0E6BE93E3A46DA19A7B916F04A4C6645DC0FDEEDDB3DEA5B27B6B1C32CBD2F1A95BCD692C3A6CE8D1FDDD472A32729C300798FAE7D7AF6ED5F3F9B2F2C9F47870F0C577F0DB8785FDF44C573B8AD7161BAC73726A369B1D02F748BFB6BBB2B47765F4DABE8E33534F9995DDDAF371AD6B535AA08B4D93CCC632C718AD328D6D2757B86334C8E598FC43B7D2AEE216B7E1EBEF3831832323AD2D22C474ABB68D515303BEDD292948BE83A8139D87AD6BC9344B9411B804570AEA502A91823A5406000D85018014065031B74AA3DCAA37E551F4AA0CBBFBD1071D28AC03EDABC2571AAF05DA713D8D8BDC4DA530FBDBA282521DC7367AF28CEF8F63DAA7DACBD38DDD76CFAEF55167E0AC894231C3139C77C579BE44E9EEF877B6976E447E5BEDEBD2BE66536FB98D592C48B8083976C0FF00BD79EF4F444DC13431F2C6EE8B237C20138AC78EDBF29160D2DACC168DEEE21919C13FA7AD244B943BD13E0B857128E46DB98EE083527B6EEAC59E059DED9939958A8DC9190003DFDBA574EF5A6378CBB2D1BC66DA50238E39300B0237CD4F29A3EE17D3BCA64699B0644CE327DFFA7E9EF4E3B3D99EF7A37B62B753124288CCA0B38F8401BE338F4CFE9599ACAEDABFB61F73D8E59EF2E12157F83321C00A7A01F5F4F6AEB24BEDC6E771EA23357D6744B6899669010C814E4E0E7A6549EBB636EB5AF0F2E9CEF3F85DA95A9F17E8F05C33DB48276D95555D798FB904FF000FF7A4F8FBBD339FCC93155B5AE38F3E6E5B36B5E7575566328C0EDF10EC3DF715D67C5FCBCD7E5DFA2038B345B987CABBBD8EDA724821C146F98DB046DD41FA5632F8D9637A76C3E5E37D9FA5CC3731ACD693C73C67F7E360C0D71F1B8DD57A7F5259B7B9D6583287279BBFA575C638E4A1F89517369B29CFC43A7BFB57B387F93E7FC9F559058C6AD7011C81938F8B38AFA4F90B8F045A5CDF6A6B6567061EE265546505B60464AFBE0677E95E5F9196326EBE8FC1E2CF3CE633D7DDFECD37C66D0DAC1B46D5039944A1ADE495BAB32EE07D37AF9F86772F6F7FC8E2F0EE2EBF67F863B8B98C900E0D7D0F8EF91F25D4761636C2042D12938AF64784F16D6DC74897F2A0504310DBCB5FCA80E228FF00C8BF95018228E80501C28C741546722B15A196A038A067AC5D7DCF4F9261BB01B0A08EE0FD6C6AD0B3156520E006EB550EB89AE25B6B5061DD8F404E28A2457F34367073801DC02797714434E20E26FF000C308756C3B05181DCD034E34D5ED6E7856F2CAFADCCD69796EF05C263F123A953FAD1674E07E28D1E6D0F519B4DB8F8A4B7768C123F1804E0FD460D671CB7B75CF0F193FB9DF052B0D439C9C646C0F56F7AE7CFFC5DBE27F369287F6B1018C9009C75C6F5F372F4FB78D34D678B1F4F93FC3AC4946C7ED66F2C92B9F4DB1578FE3F97EEAE7CBF2FC3F6C405B26B4244BB58EE2EC49B9578CBB44739CEDEDFF6AF5C987A7CFB9725BE495B2E2DD534C79399FC911ED1A3E0C401DF071F113918C8DB739A97E3E192FF00539C58F4AF15A486E6249ADBC824733EDCE1475C7A1EBD715CB2F873F2ED87CDBF7177E14F12BFC4EE31214FBB16C2FC04807B6D9C8D8F718DB6F6F372705C5EAC3E4CABD699A92EA2CCA405DC02A77C1C0FEFD6BC99E363D9C7CD2FA48E972660BA7490020372ED9CF6AC61F6ED6EF48E9352FBA5B3491128EA1B0A37C9F7F6E95BC1CB92EAB3EE31D6751B9800B29825D33732CB148DE620C0F854018DF3D4EF5EBC2633BAF0E773B7A67D73C25C5DA8C92CD2F3C68C30A752B91F1293D90648CFCABD539B8F1F51E5CBE3F2677BA28F0F35F9E248A6D574889E3272A5A40012762072F6DF07AFAF4ADFF553F0CCF859EFDA4ADFC34E2108CB67AE691788A0E179C991BD148C0DB6FE15CEFC9C2FB8DCF89C987DA2357E0AE24B7943DEC1CF20FC02D5D7D3BFC3B7D07D6B5FAD85F4CFE9652F699E1492F34641637915BA23FC588E43349939CF3EF907FB35C3924CFB8F47165719AAB720F2D8901B95867E75CA477B546F14395F47957DB3B7AF5AF5F07F2787E5778B24813FF10ADD5B9800077F735F41F2F5DB6EF05743B78F5AD235795DA38DEEB95233DBB64FE66BE57C8E6F2CFC63F4BFE9FC338F1DD9DD8BDFDA0ADD62E1678090C2DB5470848C6FCCA3F99AE58CD655BF97FBB8E65FE3FF00EA4FECDB6672927D6BE97C69D3F3DF2AF6EA0B5188547B57AE3C45A80C280680CA77A03D066EB59AD0C2A038A06F7D6A974811B71E940869BA45BD837FE1D79467357B0F2EAD92E301C038F5A016B48D951428010606D550DF50D1AD2F591A5404AF4C8A83D7BA359DC5A081E352318DC5071C7DA8EC2DA0E2A84C11AA9B5F3229481DF9C95CFD3F415E5E1BAE5CE3E8F3E1FF00E3F1E4CFF855155D1F72E3E227D056F9BD31F1A7EE68565652EA122089B0E632ABBFE23F2EF5E0BD7B7D496D23A3E89143AEBFDF1CB4EEA4BA124823E677DBD299F2FED73C386DCB7560BCE29D074178F4FB7D3CEA17B248122B38579DD9BB28C64FF0ACF1F07272CDEF51AE6E6E2E1EAFB57B8878E75582EA7B1D4380745B69226E5912E9CC922923383CBDF1D476EFD2BBDF8F8E17573B6BCB3E4E59CDE38C93FBD39E078ADF8C6FCDB41C27A4C8CB134C12C1396592307079031C3119C919CF5C66ACC2596636EE2DE5B8D973935579D1785347FBAF9D6DA6AF91825E481A48E48C8D88700F51D0FA57972CBEF6F74C3AE8FF0049D2974CD4635B2BB9DA24C90ACF93EFBFBFF2AE1C9DCE9AC7FBAFBC37E6B6997CE07EE139F4DFAD79F1F574F65B3515DD4198298B2492C700F4DEB5876E5C967D8BA669F14219ADED9A7B87192C00C9FAD7A66B19F9AE1E372EEF50586CF51BAD76DF4DB0B5FBFEA93ECC0388E1B407F79DCF6F619638D8575E2C7CAF8CF6CF3F24E1C3CACE993EBBC5FC67A5EB7AC5B69FAF3C8B0B4ACC2C6C82989223869179B2C5011CC73DB24E0671EAC2499DC30C77A7833CEE584CF3CB5B3AE04E24E3BE2096FA2960B2E2892DADFEF2D048BE45E4885B05A371F0B30C8D8F5EDE949C7872CBAF69FD467C37B59741E2AB2D52396C565B81751A91F77BB4E4B88180DD1C771E8475AF1F2F0DC3B7D2E3E6C793E8EED74C4BFB64F3623E691B727E1201EA76DEB3E5AA5C3EE13BD845A46228CE4F43DAAE1DDDA66A671AA79BA54CE00DBA31FC208AF4F15D64F373E3BC2B2FB2B558F56B672998CCEAAC39B23391DFD2BD9C99FEDAF070E12E71D336BC39776BA72C28B996D5448ACA3D37CFFBD7C1B95B96DFA4E39AC768BFB415F99785B4631E11752BA6B8299DC0193FAE2BD387776E1F2F2FD9315D7ECCF246D6CA0F5C0AFA9F1FF8BF3DF2BF93A462FF009631E95EA790614075A01A015A0383B558338158AD1402A011402280E2B4068046F4061440919DA83953ED19A37DED78D270A4CB65A94533123A4442E7E9F157CDF2B8FCB7DA98CCFE04AC878423FBCA4931D97380318C9EE7FDABB7C8CB574E1F0F1DCB5A4F07AFC439C96DB23D88EF9AF072E4FA5C78F499D4F48FBEB2F92D1A5C9EB231DD47BFAFCEB9E39EA76E996283F0CA3D3F87B5C91910AEA027944972E9FB4B95CF55FF002A8FA0C7CEBD79726594EBFE8F1FF4F85965FB30F113852FEFB8C24D6B869A4BC8EF6E16F23960705ADE61824633FE61907FA1ADDE4BE532C6F6E1382F85C339D2E3E05F0DDD709EBF3F116BB697B1CF0AB411A81B492BEECC5FF085C1C8F5E6CF4A9BCA795BDDAD7E9FEA78E38EA4FF00DFA6A36706A375ABCBA9689A2C313A2F34C8660E2E0EFB3A900027237EBF3AF2658E5FC9F467863878E77FFA45F1A3DBBEB3677705AC764CF161E04EA8C090C1BD4E463E40571B9DCA77D18E3AEB7B4DE83005D1EEE6795B240180BB6E7A67E95C319D5AF55F722B1A9E1B53543B2F4FCEBA61D470CE76BDAD9DC47A2C5A7D8EA167A745E5A9B8BAF255E693BF227F971EBBD75C7CAFBBD396F1F2DEADFF00B2B76575A9F0BCB2B583C7748195C23C2BE64AFB0C961D3AFEB5DF1D63EAAF2F1CE69DC645E20701C77DA8EA1ADADDC1631CF72ECB19471876C168B3DD49623383DC6F835DA636E572975BFC3C770F1930D6F5F94EF87FA4270549A84B232C9A94DCB6EAD1A10B0A72F3F2007725B6393E8055F1CB19E298F0639EADBB338F4BB9D678C23BE9522492D94957F2D4B3A9DF25B193EC0F4DC6D5C73B75E2F4C98E3DC8B7E931BFDD92DC0F8D01CB67006FB8AF3E4F44D6917AFA01CCA830A0E323A9F7AD71D72CE2A1C436A26D36E547C40A92A31E9BD76E3CBF7473E4C778335E0ED2A7D7B5FB2D2E1505DA54E6EC3979BD7E55EAF959F8616FE5E5F81C733E592FA9DBB0A54FF0CE1ED4E1970F2C16AD1CAFD39B60322BE5EB5B8FB3EF5A60FE38CD89387ACB9CFEC2D0B720E801C6F5DB8BD3C9F2EEF28B6FD9AF5468F505B7276CE2BE87C6CBE9F1BE563F6EB7B36E6B746F515EE780B8A030DA80680C280C06D546702B15A1C74A80D40614061540D50602804500D061BE33C113714F14E92CA0FF008C6930F286EEE4601FFE483F2AF95F2AF873F947DDFF004F9FA9F16E37EAD73BF08DB9B6B49A29367599C4808DC303823DB04575F91979595CFE263E18DC6B43E0B51CFCC73B1C0C7535E0E5EEBE871F58AF122C6432B3E47267AEE3EB5CCBDA0F54D279E51771C2252F118E6C0FC4BB63F4DC77AEF872699F0ECFB47D22C9A1802C12298B988C315C931B2649F6E6247A124D749CF64E99CB8F77B5BD20478DA38DA411BB862AD92176C753B9C0DBFEC2B9E7CB95F4E9C784C52968D169F6724ECC595413CA0F7F6EF58DC93791979657514CD62EA5BAD721795CB3B6E475AE1BFDB6BA638696C82778B4B0841F8CE4E37C0C573DEB176D4B559B9943DEA39258730FAD6A5D4DB9DC776C5CB87E74B981EDA511E588556937C6DFA7BD75E3E49E9CF3E3B3F74273DA9B772B080573B0F6ED5AD77D3532DCEC95C468C91C7704AAC5BA02BB29F507D735DF1CF5D395C65BB885D4200D33346B1BC92B066655F8B2A30334CB936930FA3116CD6F88D6302490E32C771FEF8CD72CB2FCACC37520D19B7B7099218AE01E5DF6F5AC5EDD662AFEB3232AB038EBBE7FBFE1570DF931C9AD2BD790BBD9481085675C6738C0AED8FF00371CBF813F07B42B5D3B4BE24D45D81BCB79108FFF00CD73CC37FEFA1AD7CBB72CF5FD9CBE1CD49FE5A76A3AB3DEDAEA45955B3110EA5BE224FF00BD792DDDAFAFBC7534C6BC71653AEE96BCC7CC8EC82B8C75391FD2BD1C5FC5F33E55BE69EFB3A44EDAFA919C730AF6FC69FB9F33E57A76669A08B38C7B57D08F9A74280450185018501C74A0CDD6B35A1874A80C280CA680C2A83550614061403418EF8FFA7DDFFC43A4EA16831F78B7F258E33F146E5947E4D5F3BE76325995FF000FABFE999DB32C27F960DAFCF17FC53AA4902246269BCD655ECCC0161F3CD7292FE9E2F563759E513BC1D305B8450D5C3923D187E17FB4424ABEC109F85546EC3D315E7DBB5C770F115D6558C46486EC40CE7DB35653C3A3FB659016E48E3F3154900F5F7CD6BCFA4B81EC51BCCCBFB6210E3E15E959B9EFD2CC4D78AE716B6E96F17419E619EF58CAEEB78E3F6A959CC6E38862CEFC8B81F5A97AC57EF4B55DCA52D396304E074CF4FEC573FECEBA5726B806ED719006F9F7AE9AEB4C4F69FE1DBE68AF1588257231BEC6B38F55BB8EE2F3736D04F6EB305CB46370B8F8BE55DF7D3CFAD547DC31079250CE5400323A6FEBD71499D97B2E1F836B94004AAA115BA153B1F5EA2972598A362B10B2092424B9C637D85676D68C355BA60240C720360B77A9325F0915AD4D84B9C9040F7AEB85EDCB92748B66510EE4E79B1BF7AF46BF73C96FEC2DC2370F3DA6A3C3F1166F3EE62927745C03185D803F318FA1A7C9CBC6A7C4C3CAED68B6B0F2F55789108F29448F9F53D33EF5E5FAEDEFB359CD312F137564D4F8CEF0ABAB476CDE42B29EA475FE391F4AF5618D98C8F9BCD9CCB92D6ADF663B5125E89B1DF35EDF8D8BE6FCBC9D6B6BF0C2A3DABDBA784A7355D26C6069A363AF4A86C20EF574140C3154DB3715CEB638A80C280C280C3AD580D5408A038A01A0A8F8B9A54F7FC2125F58A87BDD2DBEF51A11FF003140C3AFFF001C9FA579FE4F14E4E3FF001DBD3F0F9EF0F2CBF9E9C91C412349C4B75726268FEF2AB36EB819E9B7E55E3C66B8E3E9DBBE5A97E1A6667277DB6C03B9AE3C9F87AB8EFDB44D267761CC4FC3D0023A578F29A7AE589EB72D2151F0B1E61920E0D63B5D9C34ECB1322365724051B0E9D6A6FA6A63BA7DA6BF25A8258AB11CBCE77C0FFBE2AE375172C7B577888CD3CBE610554E7A8C126A4DE59196B1C511C3AB99DE63D73818F9D74E4EBA73E39BED3B7C03C0132C36CEDD320D717A5582CFF7FE527E263DABB49D385BAAB1E9C9CB3C60E0E0FAF435CF29A74C72DCD4685A748D24796207201E5FB9C637FCABAC73B0796D4B28C00CE06F8DFA6F9A5886B3C65A162E839CE0171F88A8EDFC4564D6AA26E676E4E538CA820FBFF62B16FD2DE95FD46546E68F043636F7FECD6B14AAF6A59CB0DC91EBB67DEBBE1EDCF93D22642795932096D9463A9F435E99EDE2CFF8A4FC3582F649B52BBB7F2D43DD7941B9B9B979546DF4FD6B9FC9D5CBFC35F1AD98F5F6B171C6BF69C23C15A9EA123079426CCC7E39A66D957F3FE02B9F1E1793398C7A79392716173C9C97F7E99E42F239676259DBD493927F3AFABFA71F06F25AEA8FB27E65B75722BBF163A7979F2DD753447E003DABBBCC50501C1A030345D868830CE2AAB3C15CABA0E2A030E940614065EB56035502B4061406A0097FE5B6C08C6083DC544723F8DDC38DC35C490BC2BCFA6CCEEB0367062CFC5E591ED838F6AF167C5E1BD7A7D5E3F91FA9E3BF710DC2EFCAEEA082588E5DFBE36AF1F2BE8F176BCE9D72C19519B97073B0DB3DC579327AF19A4ED85C32C4EBCE48276EF5CFE9D663B4ADA4066E4271824007D054D372E9356D15BC16E64B83CCBD021EB8F975ADC924DD672B6DE94FE36D6C0BA261203A46428C6CAC46335D70C67F2AF2E7DDF133D06D716E831B63276C93F4AE195EDECC7A9D26A3D3CCB010412CBFBA76DAB331AE9965A556FA2363AF42F202A39F07DBD2BB71DFA797926E6D35A7DF358EB48C4A347291907A669EFAFB2E364DB46B39AD9903A308C91DFD2A74D76928472060E01CE31D3181FCEAFABD97BF46F78020E4538661F91F534A93B5475B66847322924EEC47623F95736EC5656EFCE91D4AB643107D7E95D262E172ECCF50039981193F8722BA63D5673F485951649954E3076C8D88F53FA57A78FBAF0F35D4A9AE06E23D1B46E16BDB8BED5ECD256BC9CCFCD2AE500638071D4E307EB53978F3CB3BA9EDBE0E6E3C309E5587F8B9C78FC67AB470598923D22CD89855B6333F4F3187CB603E7EB5EDE0E09C53FBD7CFF97F2AF3DD4F514C8812C0576791D91F651B0687478E465C6541AED83CF9DDD748AFE118F4ADB98E280E28041A030A03035467ABD2B93A8CB501C5008EB4071560115408A038A2068A16DD48A8307FB4C69A8FA2477CF03C9F769D59794F4276FE75C79A74F4FC7BFBB4C7786B992E21590F23FEF0C753E99EF5F37966E57DAE1AB5C53C8B73F0A298F9863277CE7F4AF358F66EED66D1B0EF976C0C753D8571B1D65AB9E9E8BE482C5428C163B77CF41567F7532BABB7BBB9CB1F857AFF004F9D66DDDDBA6A49A8A0715DC4367C417515E3F279AE248D9BA15C0037FA57B31C3CB1E9E0CEF8E5DACFC277F6EAEAFB48A7B62BCF70B8DDBB61C9328D05759D39072B59C4A393A000EFF3AED339F863C6FE597F14982E6ED98148C072C77D87D6B96385DEDBCF9249A45DC6A16B750AC369234F333AA45C8A70CE4ED83DFE95AFD3B2F64E5F2E9A75B16881076E5F85B07B8AE76775DF09D44B585E1605582E07E1F7FE19FA55C6A658E86BC9525C20C1755D8E3A6C7352DFA4934ACEAA531CA016217193DEB1172F4A7C271AA1450B8618C927A7AFD2BBFF00CAF2FAC817A4BC6C8AC407054BFA6075AB8A5BBE90B2C8D6A8F791B44CC885D822FC59553BFBEDBFD2BD9C33763E77C8CBAAE7094B4AED2CA43C923191DBFCC49C935F463E650AD2A253876C9EFB5482045279980A90FA77B7815A2FF8770F40397079476AEF1E6CAEDAA0040AAC8C280E0D0181A01A030AD0CF8571AEA30EB501C500D01850185681850180A03500E36A8281E37E9C6EBC3CD6A44FC50DB34C0E33F8773FA563926F16F8B2D651CC1A04C19ADE505D804CC7CDB9C63A75C01B7A6F5F2F937AB1F7F8AF72C5855DB9525C8F89C0EBBF4DC9AF3D8F56F7570E1FC48810E0A8D8EDB9AF3E4EF8DBED71B87582C56256218FEE03DEB56F44BBA868EE2358CB96D977381F3DEA4C6BA5CE432E21BBB736BCD2DA473606234900201CE763D8115E8E39AAF2F265B9B522D2E1ECF599934BE4D341EB132B496C49C7E1C7C40EE7F0EDB138EF5E9D6394EDE2F3CA558A7978A2D203765EC2E60D864C8E8013FF00B69FA58DBA8D5E4CB19BA83BAB1BCBFBB6B8D6A5B6BD4400A5AC45A3B7563B82DBE5FB6EDB7702B570C719A8C63CD7F92E1A63410491DE2D9AC4EB811B729E7E5230D827718CEE2BCBC9BFA7BB872C6F55664BB4E4209EBB3729EBEF5C3B7ABCA0D6D70CC55A20E8C3E1E5C6E40EBF2F99AE7658BE52A40DF3CD6AB24640757F8D48FD6ADCB7DB3AEFB41EB0C1433260E77393B1353518B96D5592266BB590286CB60E7BE6BD12F5A79F29D96D5025B9073CECC0E159B700E323DF1B7BD5C275B73E4CB575147E34D48D9F0D6A77B0A1992381A329292A17CCF879863DCE71B57BFE3CEDF37E55EBFCB09C0CE076DABDB1E1A716F6D34AC0471B313E8288DA7C09E04B8BAD522BCB984800820115AC639E793B57862C56CB4F8A255002AE2BAB8D4C8DE8838E9402280C280C280C3A56867C2B8BA8EB5018500D01C6F5408AA0C280C0D01A80C3352846F2D21BDB792D2704C53A18DC0EB823069ED1C3AF6771A36AF77A40939AE2CAEE5B7E4505B98A12076ECB5F37931D6563EE716732C664B25BFC5A446D1F303E702723607A0F9FFB5792FF002AF763EA2F1C38CB1A28E6048183EF5E6CAF6F4E3E8E751D54CAD3149488EDC10CE37000EB81DC93818FECF4C70DF75CB933D75108FAA48B6293CB6F2C51B467CCE65F8500CFC477DF604EFE9F2AED38F5D3CDFAC65A9EA89E5DB410C0243134459E4C63E1741945C1C819C671B63DABB61C7DEEB9F27275A856CF588E191AE9E684C2B1140044C3CB24679551464B93B00B938077CD6B1E29AD5632E6B2EE27A1D4524B0B7B1115C31770F8954078F29CCAC8B8C39C03F0ED804F7193DAFED8E5BF3BB0714C70DD081A411A465019A397958AC6A8013B6467AFC24118520E398562F5E9BC6CBECCEEAEF12432C13AA08101F8BE35588939603A9048C02338FA570B3E9DE65DF671FE2D046DF787591AD25079E52C30A7D1B1B0DBBFB7B573CB0FB6E72DF546B3D6E3B6B895A6B97C2486253CC1CA36C403BE7A6DF955F0EDCE73DFA4BD85F4BFE2623017CA725588393BFE1CFBEF5E6E5C7C72DC7BF873F3C7B25AF3F91A8AC449225F84647EF1E95CB1F6B97A30BC13C013251554A93BEE08DF6CF5E83F315E8C7BE9C33BF68BE20BB32B23308E58C31755604301B8EBD4753D2BBF1FA79796F7141F16EEE6B7E0A600151A95C468AECC0B322FC4C3077C640E9E9F3AF77C6C6EB6F9FF002B297292325B48FCC9917D4E2BD35E5746783BE1DC1A8D947732C01988CE48ADE33A72CF2746704709DBE968BCB10523DAB7239DABEC4811001559283340614061406140614022B433E1DAB93A8E2A50619A80D4061406156030AA0CB406A0106A01CD072F7DA7B85D74BF10A2D7ACB9E1875887CE97957E11708795FA7AA80C6BCDCD8F7BFCBDBF173FDBE3F8557449DE6D1668CA7318E5570C472E0023AFD0938F7AF9DC98EB27D7E2CF782DB6172E9A7DD34658C91A654E37071B5796CFDCF56196E10B89E7444BC572923C6C5188C0738071CBEA307AF7F957AF1927B78B93797514BB5B8FBD6A2A5AE30ECA3995A4DA400EDBF4F5DB7C935D6F51CA6197DAD565676B71123C97905BCAF21324DE600CAA0E40033BE2B94CAC7A670E567A4F68BA25925EC13D8EA45C461072C3361D8FE16F6200FA9C7E7AC396CA9C9F172B3B891D4787209E586D216BC376832267906D85C17040FF009993907B8C0ED9AE9FA9F559FE9FA2D7FA3D85BE96D6D73A84B6F381CD13B5C9E688F42067B1F8BF33EB9AE7972DFB6F0F896FA8AEDDE920CC8D36A7049E58082489C02464123973D3D3D2B1FAB5ABF1EE3F4ADEBB3436CB2482E95E797E078E1DDA41B65427F94EE327D2B785B7B71BC5965D68EB49D3B89BEE46F45A4296AB160C40F34B24471B303B61719EF8DB14B9E3E8CFE35C3BB564D06DE4616AED8959E48F1CAFCB207272495F963A7A8AE1C976E9C375752A538D6E601ADC31A392527E51BE0B60E7EBB76AE58E3DD77CF29D18EBF3A49691CF68ACA41EBCDF17CBE7B574E29FB9CB96EB1ED596BD5932EC1A458E22ACADB973DFE98EE0FAFA57AB1C74F16795B595F8BDABDBEA1ADD9E99653096DB4D84AB1C92DE6B1F8831E848017A57D1C278E3A7CDCAEF2B55EE1D80CFAB5BC78CE5C51977BF823A547070EC194C12A3B5778F3655A7451AA0C015592D402280C2804501C0A030A030AD0CF0572751D6A50706A0350083BD0196AC061D6A830A035008A03815919FF8F5C3CDC45E1E5F410122EAD07DEEDB079799D46EA4F60467F854CE6E37C7978E5B72BF08EA33413B4404263B82540C7398D40DF6ED9E9EBF957CFE6C3EDF5B8392F78AF5C31780EAF71A7DEC714444411B6DC139DCFF00AB7FD3E55E3E4C7D58F5E39FB8993A1C4F3491C2F98A30A04607ECDF073CA0E739DF71EF59F331C3CA9AF11E996D79671DA1B58703654E45C018DB18DAAE39D95EAC33FAAAAC5C376B6E2377B531B392C5A373DBA8F415E89C96BD18F1F1E5D44BE95A4B94516978531D7CC8C31527D0820D3CB1BEDD7F4AE3EAA6A1878812028BAE2C69FB841700EDD060D3717F4F77B84A4D1AE645E7BAD45650403CDE5EE73F3353A85C72BD2266D02DA594AAC325D63F1062428EFDB1DAA79EBD2DE39FF353BB1D1AD2D391FEEF0A608D8285C0CF53EBDBF8D632CEE9C33E4C71EB15E74DB68DE3CCD12B7302A4F4EF8CFD6BCD9572C7197DA421B4D3E1BB86E23B441203CDCE5075C1CF2FA1C77F61571BB72CB198ED49BEB9FF0013E2768A68A33F7565902862486072AC08C10475EFD08AED26B1DB8657CA98F145FCC6D2E96F2DC0E69955820C9018EED81BF519C8F6CE2BB70E3BBE4E5CF94C7190D268A0D36D2E245123DCCF2C16F6C8A81BCD67E528BF519CFD4D7AF8F0FB783933DF515DFB4BF86F2683F73E35B08BFF000B79CB06AA883686E31F0BFC986C7FD43DEBDB674F0E396EA83E17D9FDEF8A6D9319C303589EDACBA8FA09E1D5AFDDB42B7503F705778F35F6B50355061D2A01A030DE80C0D01C1A030A0115A19E8AE4EA30A941C54061402280C2A83D502280C280D406076A9434D523F32D997AE4608F5A11C77E2C68A78438BEEB54B6889B2B899648D04ACA2290900E1546F9EBED8AE19E3BDC7AF8F3B8EA9958DF0171677497189DA432C98032B961827DF1CDF98E95E0CB1EACAFA38D97BDB55B2BA0FA7F9A4A3730C82BB67B578FFB3DB8C93B842F8991F2BB4887E1C9D8EDDBD3FDA93FBB7ADF710915E886EFEEBCAF92DCB330DC2939E84ED8DBE9835D661E5DB965CB70AF5CF12DA69D74D12D98BBE419CA8C367380A467F1676C7B1F4AEB8F1E55AFFE42E3D54EB6BC1F4C8E7B7D3A389F9D472B2194312480028EF9233D8526396FA6B2F9B72EE533B9E23B8745592C6042D22ADB230E432AF28CBA8DFA0C6C4F7FAD598E559BF3BC7D1AE97AC4FA94CCB6ED8F27E29223D9727661D72307F3159CF8BC676E3FD4E59DFF0027D616D34B769E7CF2E03BB3236005036233E9DEB96567D3A71CBF69F8AE92231594202B3644609CF7AF3D7AFD4D9ECDC96D60ED2CEB22E73E5E37120EA720F4F6ABA73B656796D7AE354BDBFE6F3A3079C1C0E6418C301DCF4CE37C67EA3D7E3FB64787CBF76D5BD46FE0D72FA1B9776B6559DCC73972B940A18ABAFA30C72B6DD71E95EBE3C3C269E3E5E5F3CB6BAF82DA249C47C6B3EBED0CC347D0B78039FC5390562077C164524FCC577E29E5975EA3873FFC3E3EFDDFFDADA353D26C35ED0EFB45D5A159ECAFA168674638383DC7B83820FA8AF5C781CA1E1FE9B67C1BE314FC21AFDC8B7B882EBC8B79E4DA39813FB339EDCCA47D76ACF86BB6AE7B9A777F0FDBB5B5847132F2955008ADB95498AA04540614023AD01C75A0114070680D5A19E8AE4EA30A80C2A038A011406140615A02280E280D41E14059579908A88C3FED01A24B2E8B75776E009624F34123232BBEFF009572E4EBB7A38757F6D731D94B3C5AAC96F740428C09E663BC9B9C6589DFFA572CE4CF1F28F561BE2CFC726ADC2F7F27DD8372CE98214A18F95BE641191918C57CBE4C7C6F6FABC594CA74B41E59DF99011BFE1276041DFF00BF6AE7B7A719F453FC3BCC49B950CB2B205542C5570307F51D698E7A4CF8E5ED1D73A55B896F1208964917227F8B0CC9DC03D73BE49C8EB5EAC32CACDBC39638EF57D9CCB9B7F2C451C4E39DF9A389F1FB2E8FC83F74A82001EC7D6ACCF7EDAF0D7F1AF5F691717371F788EDC030DBCA9671248A0E188DCB138CAE3EA081E94BC935A49C56DDD174DD1E6B4B8323C5009C264B432F360360646C09C72F43D81DAB8F2656BA61C7314EDBD9B476B969565E65F8CFAB6F9CE3F4AE16DCBB7B30C6620D2D2317324F2B2FC1F84B0DB3DF1FD69AE9ABD2BBC77C41F768A525CC56F9E46655E63BED9C8DF06BBF071F957879B3F052E7BED4ADCAE9BA6796A739BD6760A1915BE27191B1231923719F957B70C663FBEFFB3E7F25B97EC9FEE7BA170DEADAF6B167A4E98AF3DFDEE16DD1BFF2A3FF00D463D9002700F4EB4B95CEF8E3EDAC70C38E79E5EA3A9348E19D3F847866CB8674B48DA1B45CCF2E70679C8F89CFF2F418AFA3C784C31F18F95CBCB7973B950DA2B2B9C8700EE76E6ADB9B903ED846C9BC5E3041CBE6A69B07DE4A8C1E72598647AF2953F515ABE923A27EC83E2D47C73C269C23AE5DA9E28D1E20A8646F8AFED86CB20CF575180DF43DCE333F059F6DD8556461B540614020E280C0D018502371790DBECEC334090D415865771F2AD228E2E21FFD55FCEB93B158E547FC2E0FCAA0092E218CE1E40B40AC53248399181150213EA36909E579541F9D02B6B796F38FD9C8A7EB40ACF71140BCD230515761BAEAD6058289D493DB340EDEE22487CD2C397D69B09DAEA56B72C56290311D77A02BEAB669702069179CF6CD10FD087504743455638FB495D4F43BBB62A0996178D76EE548152CDF4B8E5AAE38BBD362D534783CC5CC91C60730D8FB8CFD2BE6E19DC327DCE5E39C9818681A8BD9DD47697771209A4B8F3395B64206C093EB8FCABB72F1CCE7948F2F0F25C2F8E55ACD96AF1CFC92A172CE400026C1719CD7CCB86BDBED639CD749D86EA695408C0CE7A2EF9F91EE2A633EEB595DF50FECE0B38E24F31A279518BB9CF3313B6D927DB3F4AEB26FA71F2F1BB2B756F1DC46F1C60372825BF08E5DF0773D7FED4B2B52C9DDF62C515F4F6AD711C8551432BB2B7E1C100EF8CE4636FD3A535A6E59949513334EF7B130E5E789FE27652AFCDFEA3FE5C1CFE5BD66CE8D76979EF223A744A582B82C72E42E47AFCAB166DBC6C8AE5C6B096D173168C44CFB9E81971B9CF4AB8E1B6793924ED40D4A5BEB9E2492DCC21DFCB3C9CE4E3CB3D0B8DB2373BF5040DF639FA58E138F1EDF173E4BCB9FED592CB4C0625BEB88DE5819D411B97BD97000DBBAE401EA4F5F7F3E7C9BAF471F14D74E95F07F811B843479757D56243C45AAA83393FF00F5A1EA221EFEBEF5F47E370FE9E3BBEDF2FE67C8FD5CBC71FE33FF00769EBD843927111CF5F9F4FE55E978D0E2202EC03CA8BCC3988931CA3A939F97E941F3E3C51E217E2BF113883881A43225E5F486025B9B10A9E48C67FE955AD65EC887D1B54D4746D5AD356D22FA7B0D42CE412DB5CC2D878D8771FA11D08D8D655DF7F66DF1B34FF1534AFF000BD4C4363C6165106BAB65384BC41D67887FF92F627D28CD8D7F3EA2886B797B0DB025DC0A08A9B88E047E5CEF45D13978818292A84D0D25341D45EFA02E41040EF44A63776EF757E64918F968338CED549D123A92C44A2F3607A0AA69CC765C4BC477D7B3C514EB84639D8FAD7077EA27384B8BB568388D34DD418307DD5852259F67DE2BEB5A85A79525A5C797CC77A113DC39AD5C47C202EA590B4863CE6AA7DA85A7DD6AFC4DA85CC82EA548E33F0A21A8D5E8FB86B59D4B48E285D3A7B8796363B7375144BDAF3E28EA32C3C3C258A564629D41A11925AEA7A8C77104AD7936038CE4F5A2E9B85CDC34DC14250E79B93AE7DAAD66336F0F7599AD75C9629A791924271CCD5169E6AD74F271E5A48B2BF23760DB50FA6D5A7EF6711FF4D5655ED7389AD22F12343E088B964BFBBB39B529BE21FB1893E14C8EB966271ECA6A91CBCD64D6DAA5E5A390392E655DBFEA39AF91CBD655FA3E2EF1883D7B46CDC128A0799931B0C03CD8DD73838CD74E2E5D3CDF23877D1C7045DDC5E696F61AA99639E09046037C23989C7328F5DF38DF61D2B5CDC73F963F6CFC7E6B3F6E5EE345D3DAD6448CC2E2D638E3C99946CCBCA39570BB6F9CFA9CF5AF2DC6EDEDC7925899897C9730B5C3C92918491DB1E5E3A9DF6C9DB6EFF2A98CBBD3A7963E3BFCA6ED6E4B889EE045148877518270DD49CF41FC7F5AD5CE6D998FE4EEF2FA2B88DE3F3300B7282806700003E58C1CE7F855DC5DD532E20BEB89ADE1B26590F987CCECC4120641CED919F6FA8158F5351A97EED36D6259DB9D12D8168C0F8A45E55236EA7B1246C7183D3D2930DEAB3972C96CDA8DAE6A37736B71D922DE98B99A30D0E18120AE631D54852D9077F715EDC38F1E39E593E6F272E7CD7C715BF83F84E24B63A86AD7172F6A802E64F89E600FC283FD3BF6DABCDCBCD72BD3D3C3F1FC6371F0638322D42F20E32D56DE316B0EDA44046DB1C1988FCC2FE7E95E9F89F1FF00E7CBFD9E4F9DF2B5BE2C3FDFFF000D3B507E7724F2731CF53DC57D27C933B88472100C7939EDF51419278FFC42384FC2EE21D591E01732DB9B2B3DB732CFF00C7C959DBFF6D5C7F25FC380B942AA81D00C54578503BD2352D4747D56D757D22F66B1D42CE512DB5C42DCAF1B8E841FE5DE83BDFECEDE3BE8BE26E971695AD4D6DA5F18C08166B666091DF607FCD873DCF529D476C8DEAB362D1C453CCFAC985C90B18C95F535291176B633EA3A87C19014F5F5F6A0B25BE8B38C2BE7269A367324EBA158BB39DB18F9D12F65B4CBC17164D2301CCFEFD2A94DDA0427395FCAAE8DB95786B524D3B58BC320CF984A8C8F7AE0EF6253420757E368AEA33CA91E074EA6AC4BE931E32C66382153D9A957149694C4F01A7FF48FE944FB42F840A5F50BA8875638A4325B2EB81279788D7520E472B038A86C878C2C61D1E3B6277D87E9422A1A9E9BE4E85F790B8C2039A11A368375F79E03EB9FD99FD2AA7DB268A57B7BF69A3CE5243516A5749BC6BAE22B2918E486AB12BA0E3BCB3D3387E5D5752996DEC2CEDDA7B895CE02228C935748E59FB3E7145F71EFDA475EE38BD5602480C76F193B430960B1A7D157F3C9EF56F505C7C5DE1C8F47E3D99A38CA437BCD7317C3804E70E07D483F5AF95F271F1CFF00CBEF7C2CFCF8F5F855751D3BCFB400202E371F3AF36396ABD1963E4AC6ADA55E07FF0012D282FF0088C48C51586D26411835E9E3E5F0BABE9E4E6E0F3F5ECF343D6563B6C07979ED4234A873E62BFC1CDCC3B850E1738C646DD36EB9714CFBC2BCF8F2E587EDCE27350E26B79204999503469E5B16DBCC9704AF2E3A8C15F5DEB967C5ABE9E8E2F91D7B4ADF6B40DD5E30B88DCDAA23DC72A8DBAB630776DD70D8E9B6F589C57EDBBCD8F4506A5652CF29BB56B764FDAB05D818F24AAB03D49504918C8F6A9FA576DFF5324FEEF58132B7DCAC6436C1A692399C025E18D79C13F9FB671915D71E1CADE9C33F958CEEA1B55E2DB5D3ADA5B3D3268F56D5A4416EB6D1373C439C307919C02158139F72B8C6E2BACF0E19BC9CBC393E4DD49A9F949F067085C33AEA5AD3734F33175897E155E6DD881DB24EFDCF7AF072F3DE4AFA5C3C18F1CD4685A168478A3889344B6664D3AD4235E3AF439E8831D091FC2BA7C7E2BCB96BEA31F2F9B1F8F86FEEFA6F7E54363651DBC31AC71C6A2355CE02A8180057DB9D4E9F9BB6DBBA8D8E6335C67F678DBBD543D6526319299001E9465C67F6ECE2C4BAE2AD2F812CE5564D2A3FBE5F8418FDBC83F66A7FE98F7FFEE56BD4239A18E76A8D02A0107D68148CF2BAC8A4ABA10CACA70548E8411D0D06CFC0FF00682E34D22DEDECF5986D388A0823112BDD318EE4A0E99906798FBB0CFBD5D6D34E8BF043C68E00E29BA4B096FCE85AC487E0B3D4C8412B7A4727E163ED907DA895B74B0B86C32F29F7A6914CF1011D6CF2CD955DCD549ED21A246A745575505B973BD45BED0B77A8DCC33B47E6118F4155751CE7C236715EF105F4528CF2E483EF935C1DA9FC0EFA471DDB456C404900E618A25F499F181DA4B289D8EE5AAFD98A4787C73F022FFF0048FE943ED05E124A62D5AF1B382BBEF42ACDAA71D5FC1C511E9C91964661BF3543489F152F9EEE180B9DCBE684415FEB13CFA2080C1205E50A588DB15564D2DDC0374D2709C906E48CAD3E99BED9E5D712F09E8A2F0EB5AC410CA92B6214F8E46F928A496ADACE751F17DAD6FF00CDE1CD3378DC98E5BBE9EC7947F5AD4C59B507C6DE2A71FF0017E9CDA7EBBC4770D60E006B2B7022848073821776DF1D49AD2353FB15DB0FF15D62E397A3C4991ECA4FF3ACE5ED67A6F9E3E69DE6F0D69BAA22E5EC2F80624E488E45E53FC794D783E64DE1BFC3EAFF00A6E5FF0013C7F319A08008D895076C0C77AF99B7D7B8A0EEADDA2B80E4E086FC22BA4AE5944A4DC3DA2EB9183796AA252857CD46292004618732EFB8FE74C73B8DEAB3E12CD535BBE00D70CECDA5EBF035B997CDE4BDB612942082002307185037EC302BD33E4E7AEFB79AFC5E3B77AD18B7007175BC0621C43A54B3CC5CB116C79A052001C849E8003D8F53DC934BF2EFE167C2E3BDF65BFE14E3737F15C3EB5A2CF3A3969A76B2CB4FBEDE6E08076DB6C6DF9D3FACCAFD2FF41C73F23DBF87DAF5EB19388F8AE6920624C905AFC01F25495C8DF1F02E37C8DF7DCE79E7F2F3BEBA74C3E2F163EA2D3C35C2BA3E93184B0B08ADE18FF020182CDD0B9AF2656E5DDAF5633BD2CB135C841F7387EF1792B7976F10EA5CEC3FAFD2AE18DB753BB5ACF2C70C6E597A8D6FC32E194E1CE1E8E395C5C5D484CB733E31E6CADBB30F6EC0760057DEE0E29C58CC63F2FF00279EF3F25CAFFB1EEB97473C815493B6EDE86BBBCE4B4F5E5032231DFF008D105E39E27D3F82F82357E2CD502B5AE976CD33463632BEC238C1F5672ABF5AB26CAF98FC55AE6A5C49C47A9710EB12F9BA86A572F7372C06C198E7940EC17600760052B48863924D007D6A0F77AA0F1EE7FA5028ADCAF907BFAD214BB32BA9560190F5045691AFF857F682F10781921B16BE5E21D1A3C0FB86A4C5D917D2397F127B0391ED4D1A744693E33F03789B631E9965792687ACCB802C351210B37A4727E17FE07DAA33AD56A1A25B5CDB592DA4E855C2E0E685A51F458A462EFD4D0DB9AB83345D46DB892F269620237E6C6FEF5C5DAD2FA9E87A84BC6769751A2F96BD7D6A2DBD263C49D1EF2FAC228E10A183677AA92A7381B4797FE161653152E13181F2A25F6A5DDF0F6ADC3FAA4F716D8F2652721B6C7CAA35754F3847876E354D79750BB954BAFE151DAAA5A5FC53D261B048EEF53D4ED74FB48B2C5E770B9F97AD344BA675C61E3170258E85FE1FA0DB5D6AF7DCBCBE604F2E107D72773F4157C59DB1AD5BC43E2BBEB792D23D525B1B37CE61B63C99CFAB75AD6B49B5500CB731DC9DC93D4D50A20037A01279980A0E9BFB14438B4D5AE307E2BCE51F45159CBDAFD3A5B8DEC62D5B85EEB4F902959F299231CB95D8FE75E7E69E58EABD7F1B3B8672C629A5239B702750268498E407FCC0906BE259AB63F4BEFB9F64757B3E9381CC0ECC3D2ACAE594FA134B7F2DC212703606977F448B7D8B6620F942CBDF977F956A52E1282E5CBC855BB7438A7B493C4423048042FAE3BD66B726FD94FBB172039E44C753DFD7152CBA372FD3CE0206280F26E3973D4E3BD66DFA6B19F6D2BC3BE186B654BEBF8C8BA74F8548FF009119EDFF00530C13E8081DCD7D7F87F1BF4E79E5EEFF00D23E0FCFF99FAB7C30FE33FEB7FF00A5DB559D6DEDC839C60A9DEBE847CD55E157BBB92EC837F53ED4653423E5031E58C9C7E628AE58FB75F8830DC5C69DE18E9D20636AC9A8EACE8C71E6729F2A023D81F30E7D52B5AD448E4F98FC64D46899F6A0F6E6A0F01DE81487F1FF00BE2A81C1E763E8290189E873F2F4FF006F955031BE31FDFF007F4A6D347092861CAE323F4AA35EF0AFC7CE3BE07862D3FEF71EBDA3A6C2CB51259A35F48E5FC4BEC0E47B534964AE82D0FED2FE1B5FE9E971A949ACE9174767B57B433729F674D88FC8FB554D567DC0FE2049ABF080D652C3CA7CB8652D93B570AE88CF08BC4FBBE2BE27BEB29F4E587C95CABF3E7B914D061E3078ADABF0FF0012A69F6F6314E0C79CB3637A49B2A77C19E33E2FD6B5763A869696D67C81959589CD5A11FB4278A171A35C45A6D8C3135CC8B9CBF451EB520C6AD3C66E35D395C585E5B47237490C392BF207F9D6B48A4F11EBDAD711DF9BFD7B54BBD4AE4FEFCF2160BECA3A28F615446EF41ECD0190501E80F02069067D2AC1D61F63BB7FBBF09F9A7E1F3E7793A6CC338FE558CBDAFD3A2355666D3988DCA953F11FE55CB93D3BF0DFDCC9B89ED8587184C611FB1BC517083B06E8C3F43F5AF91F271F1CF73EDFA2F879F9F16AFD10D4AD3FF00D22BF310492B8C003B0AF3BD37DA22D610CC795F383BE3F4AD39EAC4ADBF3F304493CBDB71CBB7E94594ED1522943349CD9047BFC87FBD1BD7942D03A050444CCDFEA39DBDE9B8C5C7F03DC79B21CAB0DF7C81B0ACDCB6B26973F0FF8724B99A2D4AEE2530A366D51C6D2B0FF00CC23BA2FF13F235EFF0087F1BCAFEA65EBEBFBBE5FFA87CCF19FA585EFEDAADB4496B6E073B33127989EA58F527DEBEB3E12B5AF5C9965E40AC738EF5591F42B6C01FB3009C753ED409F88FC4DA7F027016ABC5DAA22341A6DBF989183BCD2E79638C7FD4E547B66AC9B57CD1D7F55D435ED66FF005CD5E6F3F50D42E1EE6E9F3B1773938F40360076000ADDED3D21A4C939EB5868418F4E941E1ED507876AA14847C43AE7DA8008FDA3E71DBDBF8D20F37539183D3FEF5402EDEDF5FEFF002A015723E79F97FDA8178E43DB63550B8B8C0C67F8D05FFC3DE2FB3D2F81E5D36560244772413D41AE56297FB343F3F1E6A25770F1161F2C9A5F411FB40158BC46B69A423923556719DF00838A62B523AAF8FD7969A1AE93C1FA1C1A6BF2F23DEDC1123E318F857A0FAE6AE918EEABA8EA1AB5FC97FA9DE4D797529CBCB2B649FE83DAA86BF3A0F6C2803340655EF406A01CE064D0296C701E4271CAA4D6B14AECEF006DEDF42E0A49B51BC874FD3F4DD3A3B9BFBB98E23850AF3127D4927000DC9C62B9FBAD2C7C2DE3BF873C6BC54BC1FA29D7167994B5B5F5D5BA470DC32024AA0E6E7CE324020670475C6667874D6196B22BE22DA49F718AF41321B4903ABC7D1A33B363E841FA57CCF9786F1DBEDFC0E4D67AFCA2E1FDB5AAB86DB9771D88AF9DB7D7B0D0D9153CF0F203D71EB56317A2F0C6F90D800F70456A3161EA4431927073E94F6D5A58A011E4602819CD66989DDA5BDB595AC57FA97ED8CDBD85886E56BBC7576237588773DFA0F5AF77C4F89FA9FBF3F5FF0077CDF9DF3BF4BFE1F1FF002FBBF8FF00ED77D2A5E23885D6BBA871045A759DA40679E296D93EE70428A4E397F122A80770D9F5F4AFB131FA8FCFF97D93F0D7C58E1CF13785AE35BE1F79126B36F2B50B0936960C93C8D8EE8E0655BBEE0E08205B2C120C3CEBD042BBA1F894FA8273FDFCAA22C7A5418407CB03B6E7D0D072B7DBE78E05CEAFA3F86F6330315981A96A814F5958110C67E4A59C8EFCC87B56F19D0E5B6DC7AFD2B419CE3E226B9D9A6A11C6F4038DBA5007E740A45D703A9F4A0F1199981F41B91B7FB55801B3EA46074EE3FDA8827400515ECD0181DBAE07BFF7BD01D64C6DCC17D89C7E940E614D363B3E6B82CF3B761D17D2B209A47106A7A14D2CDA25EC96734ABC8D2A639B97D3DA8236F2EEEAF2E1EE6EEE25B89E439792572CCDF53409D07A83D9A02E680C06F9A030A01CD01643B800D03CB085A668E051F14D22463EAC07F3AD44AE8FFB45DDCBA5782BA668D6E7CA4D5F8824FBD853812476B0A7229FF4F33E71EA07A56709BAB7D39EAD67B9B4BAB7BCB2B892DAEADE559609A338689D4E5581EC4115DAF6E71DB5E167172F88FE1B0BEBEB292CEFDE2916E2DCA1549CA7C324F07F9A324EE07E16DBA57839B8E6AC7D0F8FCD6652A378799E357B639E6858C4DEE46D5F06E3E374FD54BE58CA97685B979D72B81B607EB464548C9DC8CFC856A337D961CB9C103A6F9CD5D9A39B08E2984B35EA34961680493C719C1949388E153EAEDB7B0E63DABAFC6E0FD6E4F1FA9EFF00F7FBBCBF33E4FF004FC7E53F95F5FF009FF65F387B4308135DD7638AE35BBDE5690447114098FD9C512E01E5518C64F5C9EA6BEF47E5ED73C7DB07C525955FC2AE1D9796DADE457D7EE51B3E6CA3E25B55F50BB17F5200EC73DB1C753B62F758C781DC73FF0001F8A9A4EB92CBE5E973B7DC7565070AF69210ACC76DF90F2C83BE50034CA6D63E80D869ED0CAD6F273C8636631B03B3A1DF6F6EE3E66B92A6353D574FE1BE1ED475FD59FC8B0D3ADA4BAB87EE115798E0773B600EE69AD8F98BC5BC417FC59C55AB7146A9B5E6AD76F7522EE44618FC2833D9570A3D85744459EDDFDB354252A839EC4F4ACD586A7237C565438FECD0085CE3BFF3A0F01861D08CF7EFFD283C7227CEFD3AF5AA00E3618EFD3AFE5EB44037D3A7E7FEF45177DFDB63FEF41E3D7D303F2FF6A0F670319A068ECC6B2000A01A0F1A0F63D280A4D079464D01FE540228073819FCA813DCBD059B812DFEF1C5BA15B6DFB5D4611BF4FC60FF002ADFD2368FB51CCA380781EDD815926D4F54B845FF0046215CFE79ACF1CED7260C8074AECE6DEBECC1E27D9F0FDADD704F10DD5A5A40EF25E70EEA576DC91D8DE95F8A291FF762930327A0DC1CF36DCB930FB6A56B7A5DDE97C49A043C75C3251F4CBC2A97F6A8FCCD6173D1813DE3247C2DED8EF5F17E6FC6F0BFA98FAFFB3F47FE99F32727FC2CFF0094FF00AA5D10795BB139C77ED5E17D4A48C327315420A92394038A44BAF63498546918731F451D3DA86BE8F2622D2F2D2DE6611DAE9AFE65CA8EB757D22E0458EE2352131EACF5F7BE2F0FE971C97DDEEBF2BF37E4FEBF2DCA7A9D4FFCFF00B92F1BFC531E1F703BC966636E25D454DBE970B905D1B1F15C32FA20E80EC5B947AD7AF09DEEBC56FD3856EA67666E791E56762D2C9231669189259989DC927277DEBA5BD841873294EB9183F97F7F3141DB1F63CF145789B42B6F0F788AED5388746801D3656601AF6D54602FBC918D88EA5003BE18D72CB1D2ECDBEDE3C6E74EE10D2FC3DB47F2EF35A905DEA2A0FE1B489FE0047A3C80118FFD261DEAE33A1C7477F4006C0D6817F2A02B0DB3503771BE7077FD6B2D0A00F9FF003A81440304751FAD540B05619E6E6EDBF7340938E5901C9552394B1E9F5F6A2BC460F2F2B6C371E83F90A0291F99F4EFF2F4A00FFB510040031FD8FEB45782A9EE17D8EF443303D6B2A114038A0F1A029A0F5078363AF4A01073D37A0303B500367193E941E8C7C54178F08E1337891C3C81049CB7264E5F52A8C47F1AD5F48D1FED812343C57C2FA0C50116BA4691E4B4C77E7B976F3255FF00DA193F3ABC73A4CAB125383F2AE885D42CA8558673EBDEB53B474CFD90AF619381357F3504D1691335AEAB6D18F8CD8CFF001A4D81B928E1FE4307B5797971965997A76C32CA652E3EE7A6AD35A0D3EF1ACCCC9728144904E982B344C328E0F7C83F9E6BE0F3F0DE2CFC5FAAF8BF2273F1CCFF00FD88D107E65C2728E809EF5CA3D16EBB1ED6EEDF4F7B8D62ECC4D069709B80A7A3CBF8625C77CB907E86BD3F0B8FF539777D4783FD4F9BF4B8353DE5D7FE5ED0F872F21D167E36E37D50F0F689A7C0F704C9FF003D41F89E53D71239E9B16DC00326BEE4DE5751F98BA91C65E25F16CFC5FC637FAECA278E1918C76704EC1DEDED81FD9C67B16FDE6F726BB26958891E47CE1BAE33DC503B50900C8C17EDB671FDFF00006AA26BC3ED2F89F5BE36D32D7837EF235D49D66B59E16E536CC08FDAB374551B64F423B54CACFB590EBC57E31D5B8F38FF0050E23D6AEADEE67C25A46F6CA56031C439034609242B10CF8CF57358D2AAC4FCB7AA3D81D45001CF4DA812907C5870467D0566C5264F5C0391514604E41C72ED8FFB5103BF3617049E9938047A1F4ABA04DF901E624E7638FE18FE75001519207C201DC75E5FEB45148EC7E6467FBFCA80BF2FFBD07B19EF40AC7903E127AF403A5111D5957A80734004D001A0F5007BD00AA966F87AD0382395467A9155093F4CD450C00B381560D93ECA96305EF8D7A74F7318962D3ACEE6F7CBC7E3655C2AFD59855BF8468FF6ADE1C926F0EAC35F70D2DE69BAA335DCA13661739E66CFA73051F2C56B1BDE99FEEE6094E2B5560229995AA4BA2C6E7F62FE253A278DF1E9ED272C1AED8496C57B34A9FB44FF00F161F5A99F64756F14F0DC361199ECE38E3D3A4908808D8DBC847318F1DD09E6231D371E95E1E7E199E2F77C5F9397166ADD9C535C48D1FDD2569918A9847E2661D467B0F7F4AF07C7F8B972677CFD47D7F99F3F1E2E3938EEF2B3AFEDFDD6ED0F86B4AD1F4DB8E28E2C9E28ED6C236BC90CCC4C36A1412582F4C819DF19AFB18E327EDC674FCE6596595F2CAEEB947ED2DE3DCDE27C29A168B69369BC29693F9A04C409AFE45FC2F201F8514EE13272704EE001DE63231DB0C8E3695FCD9B239BEB81FDF4ABADF61C73155010F2EF9FEFFA7BD6B48B0787BC0FC45C7DADAE99C3964D2286027BB707C9807FA9BB9C6703A9AC659C9E964753715F0C68BF67EFB3BEB77FA71E7E22D5621A6C578E312493CC0A961FE5E54F31801B0E5FAD7396DBB69C6680451AA01B2800569063B9C74C0AA3D8273402B9CFF3F4A0309B01942A92EB861D462886F97E70B80BB10A40FE249E82B2D0394AB9603273D57723DD3D7A75A0F72FC2CA7949C7332E7E13B75CF76DFA50013F164E589E99EAC3D1BD2809B63981F607B8F603D2A02903183DBB7A7CBD68A0DFDBE59EBF3A0F01BFAFF3A20D8C8D8647E554301585781A00ED41E34003341EA052185A46EE055936176E4855703E2ABE9093316619E828A4DCD40B5A0F8C1C55C4ADDFEC64A9FF00EEEDFCCEA4F26892AA9F42D2201FA52A3A6F8BF8623E2EE0CE20E189B989D42CE448199BA4A07347F9385ACEF4AF9F12C3347CD15C46D1CF1318E5461BABA9C303EF915DBE99FB36E52AFB566AACDE1EEAADA1F1EF0CEB28D8FB96AB6F2363A95F30730FAA922ADEE447D29E26B07974316F1AB3ADB6A0AFCB9DCA9053F21CC09F615C2CFA6F1BABB3BD274D1CDCFCA3989D9F1B915536E6FF00B72F89F07DD53C27D0E7562C63B8D79D30791410F15BF43F1310AE7A602A8FDE22BA6319AE4573E6C811141441838E83D06DE9D6BA5FC22E9E15F86DC5DE25EAF258F0CDAC7E45B32FDF750B83CB6D6B9E809EEDD70A013F2A9967E3D7DACC76E95E1DFB2F702F0E58C73F115D5F716EB1211E55BB39B6B5E6EFF029E62A3D4B7D2B95CADF75AEBE9B9F02709E95C2DA4C565A7595BDB46A39B9218822A93D7007FDEA257297DBD78B1B53F10748E0BB7949B7D0ED7EF576A0FF00FD99C7C208FF004C6148FF00EA1AD63E87391E8322B680CEF9192683DB6371F9500E4F6E94000F2904360FCBA5015829500E49CFA54042CCBF889C67670771EDEC2A285C0191DC37EE8D86FD5077341EC92770A7D413B30EB96F7F6A04F73BFE2276C9D8B7B7B0A80BB75FEC7CA8A0DBD0647E4283C319CF5CFF001A01E56603E12F8DB228185640507A83C683DBE703AD0388A000733103E75AD26CA3B85C85F4AA1AB31793735951B1DEA84DAB343AB35DF38AD44AE81FB17467FE37E21BBE5CAC7A7451B7FEE947F4A644756DB49F76D449C27293D41DF9BFA563E9A7287DAF3C3B6E19E351C63A7420689C43216939170B6F798F8D7E4FF887BE6BAF15FAACE53ED84DD40530DFBBEB5ACB1D24A4DB98C0E10E1C10571EA3047F1ACFD0ECDD6FED75C1F6BA75BA68DC27AD6B37A22469BEF3225AC024E4DC737C4C7073FBA2A78F64DE947D7FED75C7D77633D9E89C39A16892488512E4B3DCCB013B73286C29237FC408F506ACC6276E7ED4EE6EF51BEBBD5751BD9AEAF6F266B8BA9A5C16925720B31F724D6E4123C0FC2FAC71BF16E9BC23C391F3DF6A0F82F8CAC318DDE473FE55193EFD3AD673BE31647D1BE0EE15E1DF0CF80F4DE17D1A202D601F1B72FED2EA738E691BD598FE4303A015C5AF696D36CDDEE4DEDF286B823000DC22F651FDF5A81F6A37F65A5E9B7BAB6A532C363636F25CDCC8C3648D14B331F9006B519FB7CBCE2FD7EEF8BB8BF57E2BBFC8B8D5AF24BA29CD9F2D58FC080FA2AF2A8F602BA089E98EC2A8F6477CE7340049C6FD3A8A001D373DFAD008E941E0C47403E7406E55653F165CF623AD025968F00960A3A3632C83D056542C301872AFC232CA0E55761F17B9A04F19D80C93EBFBFF003F4A0024EC43123A038FE1501761ED8FC8515EC6E7BFB7F3A0385C8CE0FD3A554A8D3585077A00CD07BA50290FE315614E58EF927E55ADB2465359584E31BE691477E95484CD643CB307909ADC4AE8EFB16DBA86E2BBFC1F315ED215C74232EC47F0A9911D357B19E659230C76DC28C66B9C6A93E22D0B47E30E15BDE19E21B7FBCE9B789CAE07E28987E1910F6653B8349ED2B823C56E0BD77C38E2BBDE1BD5E3696341CD697AA0F977311FC2EA7D71B11D8E6BBCCEE99D2A90B11800EF590BC49CCC0313E87DB71FEF5A90A5D4AA8DCEE7BE3DBFAB56B5A42371312ACBF877C8C7CFFD852D2475C7D81F40BCD3385388F8BA48EDD9354912DED1FCA0644484B799F1F5C3310397A65735C72BDB5EDD19651CD79786FEF5B9A42BCAA98F8611E83DFD4D615391AF28C0E82AC4AC13EDC5C63FE05E1345C2D6B2F2DF7135C8848562196D6221E56C8F53C898EE1CD6A11C3E7017DBA574414E09F98A8000CFB7B507B03AB377DB036A6D400803DFA511E1F8761B50081F0ED8DAA81538DF1406924F34626625BB12339F9D1084585054EEA87F163F067F5ACB40E5C9C153EA573B9F7A029C939EA4EC081F8BE550787C27200D8FD0551EC6FDC7EB50F6541193F0E77FA7EB41126B2A03B5007BD07A80D19C3826903A63B039AD56484A77A95A7906D9A41E7AA087AE2B21FDA8C479ADC47507D8DA065E03E27BA230B2EB30460E3A958B3FFF00D7F1ACE44F6E931189610DCBB91F200FA561A250B185F6D97A63D288CEBED7A525FB376BE5911B92EACCC64A825099D4120F6DB6FAD691C2B060AB729DC7F4AD40F31C9907E120FCF6F8ABA4EA2139640ADB74EDFC3FA55B5345744D1F57E20D562D2743D3EE2FEFE76E58A08232CC4FA9F403A9276158B5A7D26F0C78561E06F0A340E148DD0BD95B012CA83692663CD230F5CB16C7B62B9522D164A005F8707B8F4A8A74CC474EA4E05691F3F3ED59C61FF18F8D9AAF9128934FD0D46936841D898C9F35FE6642E33E8A2B78C4ACA8F53BFE75A051D867E7ED41E0A718A0F38257A9C9DC0A966D45421BE172A1BB12700FCEA6C0E0938270735A4788C6DBE3DAA0F038DCE2A8062C718396E8067D68013214392060ECE7F0A9EE3DCD654047C3CA548EE57B8F727D280AE4E7E7D70319DFB54055EBB60FE9FF007A03AA9248059B3F9B0F7AA0E533D3E2F976F6A2223DAB0D0283C3A507A83C366140BB1C8AD049B7350283F0D5056A808376A82461D900AE911D61F6478047E0D5E4C1B0D71AFC81CE7D238C0FE758C967B742C4730827AE307D05614948A0F6DE88CB7ED5F318BECF1C4D1801849259AFC5D47FE26339FE15A89F6E22D3908393D0F4AE920567270416393F3F43FD6B6C9A3B658E4F735957627D85F855742E11D578DF548C4571ACE20B4E6D88B54279987FD4DFFE358CA8E8EBAB94912DE08C108C39F382303B7FB561A3EB4521327EBEF4153F1978C1781FC34D7F89D5879D656A56D14EFCD73210908FFE4C0FC8135A937597CDA8F9C2E64769243F13BB1CB331DC927D4926B601B73EFEF540601DBF3341E033D4D0283A0CEE7DB6A02CABCE09EF8A966C271E5BE06CE54654F7F9548A1507D31D8D5479B20F215E9BE4D504009902B2960402107561EBED514270539872920639C0F848C0D80F5F7A83CF9C900B6FD0B1DFAFEF1A04B20EF93EC7FBED50F63C6091D880373D97DE8168D411BE77233FE63D4E4550BAAC78C48F2A91FF00A7D3FEF5515FC5736818A00A0F7BD007CA8166C98C6E319AD0281B5406EC77AA95E61B54515065E903F8FF000ED800D6D97607D97E248FC08D272A43DC6AF72DB75239C2FF002AE792C6EEA331AE464A8C363A0ACB54DEE6400FC277EA0D1191FDAD0345F67DD66490A833DF59C48A4EE5BCDE6FAECA6AC1C696A046881B3D01E9DCF2E6BB46693BC0797D881DBE556FA458FC1EE08BAF10BC44D2B856DC948AE64325E4C3FF002ADD3791BF2D87B9159B5A7D1DB3D1B4DB77B3D3ACE08E1B3B288476F128C284518518F603F3CFAD73A43C9517EFAEC324162397D31EB5953952C17009CF4AD257297DBCB8AB379C3BC036D212114EADA8AAB6C58E52053F21E6360FAA9ADE33A472F1F6FEB5A004E4E77CFAD0067FEF8A0118E9D40EB402A0E091923D68073BE371E9EB9A01EDBF6F4A0291CD90640848C2EDD681194B0EAC31DD8EE00FF7A94780C2F2956C0F88AE7E21B753E837E951425865892BEE57A2EE3751EB4057DDB0173919E5FF0030F56F7A04D4E4E773DB38FE140BC09D0601208033F850FA1F7A05D00C655B1D81237E9D3E540BA3320211C20CFE1C038ABBD22B5DAB9B40A00141E3EB4007D28141BC636DF3D6A8305FAD541B1B5015C6D8A2822FC62A429F8D936DEB6CBB53C02B7FBBF80DC0F148A544F2CB364753CD2BD73C9A8D818B08F1B7328C7B56405A5AB4F28D8F29FCE83943EDB5C6563AE71A699C11A45E8B8B2E1E477D4046498FEFAE705491B3322003D8B30EA08AEB8E3AF6CEF6E7A0BCEC641CC14FE1C1DAB710A48ABE564E3D739EFF00DFB54AAEA3FF00F4FCB6D324978C6ECDBA1D560FBAC6B313F10B770E5947B164159C91D636A505D13B127F091DBFDAB9B44E03E7DC48FEE7273D77A453F510C685E6748E24059DDC801540C9249E800AA8F99BE2AF164BC75E26710F1631668B50BC6FBAF30C15B64F8221FF00C157EA4D744567618F4AA014018C6D402723627A7402800750280C7600A91EF41E62307AE683C321797DF344158AB6FC98207E74088E8583827192C7F0AEC76C7AD65A09271CBF160F4CFE2276D9BDA80D9C104381CA776C6D19CF41EB4047E98208CE094CEE4E3F11A02C637C639B9B63EFEC2A070AA54004730C6794771BEE7DEA8501C6727391B9F5F9500B72F70BF5AA8FFFD9, 10)
INSERT [dbo].[Profiles] ([Id], [Name], [Surname], [Phone], [ImageData], [AccountId]) VALUES (2, N'Artem2', N'Mazur2', NULL, NULL, 11)
INSERT [dbo].[Profiles] ([Id], [Name], [Surname], [Phone], [ImageData], [AccountId]) VALUES (3, N'Artem3', N'Mazur3', NULL, NULL, 12)
SET IDENTITY_INSERT [dbo].[Profiles] OFF
SET IDENTITY_INSERT [dbo].[Seances] ON 

INSERT [dbo].[Seances] ([Id], [Price], [DateTime], [HallId], [MovieId]) VALUES (1, CAST(100 AS Decimal(18, 0)), CAST(N'2016-03-25 18:00:00.000' AS DateTime), 1, 6)
INSERT [dbo].[Seances] ([Id], [Price], [DateTime], [HallId], [MovieId]) VALUES (2, CAST(80 AS Decimal(18, 0)), CAST(N'2016-03-24 14:00:00.000' AS DateTime), 2, 6)
SET IDENTITY_INSERT [dbo].[Seances] OFF
SET IDENTITY_INSERT [dbo].[Sectors] ON 

INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (1, 1, 4, 1, 10, 1, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (2, 5, 7, 1, 3, 1, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (3, 5, 7, 8, 10, 1, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (4, 8, 9, 1, 10, 1, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (5, 10, 10, 1, 10, 2, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (6, 5, 7, 4, 7, 3, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (8, 1, 12, 1, 12, 1, 2)
SET IDENTITY_INSERT [dbo].[Sectors] OFF
SET IDENTITY_INSERT [dbo].[SectorTypes] ON 

INSERT [dbo].[SectorTypes] ([Id], [Type]) VALUES (1, N'Single')
INSERT [dbo].[SectorTypes] ([Id], [Type]) VALUES (2, N'Double')
INSERT [dbo].[SectorTypes] ([Id], [Type]) VALUES (3, N'4D')
SET IDENTITY_INSERT [dbo].[SectorTypes] OFF
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'2eeee0a4-262b-46b9-ae0e-5e8185973d5e', 10, CAST(N'2016-02-24 13:05:22.590' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'bd7e586c-c711-4219-b133-91f841b55f72', 10, CAST(N'2016-02-25 15:31:03.327' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'c4047104-903f-4894-8d3a-af51883004d3', 10, CAST(N'2016-02-24 13:09:00.717' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[TicketPreOrders] ON 

INSERT [dbo].[TicketPreOrders] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime], [IsDeleted]) VALUES (61, 9, 4, 11, 1, CAST(N'2016-02-23 13:21:25.657' AS DateTime), 0)
INSERT [dbo].[TicketPreOrders] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime], [IsDeleted]) VALUES (62, 9, 5, 11, 1, CAST(N'2016-02-23 13:21:25.950' AS DateTime), 0)
INSERT [dbo].[TicketPreOrders] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime], [IsDeleted]) VALUES (63, 8, 4, 11, 1, CAST(N'2016-02-23 13:21:26.437' AS DateTime), 0)
INSERT [dbo].[TicketPreOrders] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime], [IsDeleted]) VALUES (137, 7, 7, 10, 1, CAST(N'2016-02-25 16:13:26.527' AS DateTime), 1)
INSERT [dbo].[TicketPreOrders] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime], [IsDeleted]) VALUES (138, 7, 6, 10, 1, CAST(N'2016-02-25 16:13:26.763' AS DateTime), 1)
INSERT [dbo].[TicketPreOrders] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime], [IsDeleted]) VALUES (139, 8, 7, 10, 1, CAST(N'2016-02-25 16:13:27.283' AS DateTime), 1)
INSERT [dbo].[TicketPreOrders] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime], [IsDeleted]) VALUES (140, 8, 10, 10, 1, CAST(N'2016-02-25 16:13:28.370' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TicketPreOrders] OFF
SET IDENTITY_INSERT [dbo].[Tickets] ON 

INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (27, 1, 10, 1, CAST(N'2016-02-24 11:09:22.117' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (28, 1, 9, 1, CAST(N'2016-02-24 11:09:22.117' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (29, 1, 8, 1, CAST(N'2016-02-24 11:45:01.507' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (30, 1, 7, 1, CAST(N'2016-02-24 11:45:01.507' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (31, 2, 6, 1, CAST(N'2016-02-24 14:31:27.587' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (32, 2, 5, 1, CAST(N'2016-02-24 14:31:27.587' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (33, 3, 5, 1, CAST(N'2016-02-24 14:31:27.587' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (34, 10, 1, 1, CAST(N'2016-02-25 15:36:56.070' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (35, 10, 2, 1, CAST(N'2016-02-25 15:36:56.070' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (36, 6, 4, 1, CAST(N'2016-02-25 15:36:56.070' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (37, 6, 3, 1, CAST(N'2016-02-25 15:36:56.070' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (38, 6, 2, 1, CAST(N'2016-02-25 15:36:56.070' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (39, 11, 6, 2, CAST(N'2016-02-25 16:13:53.813' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (40, 11, 7, 2, CAST(N'2016-02-25 16:13:53.813' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (41, 11, 8, 2, CAST(N'2016-02-25 16:13:53.813' AS DateTime), 10)
SET IDENTITY_INSERT [dbo].[Tickets] OFF
/****** Object:  Index [UQ__Profiles__349DA5A7FD119AF3]    Script Date: 2/25/2016 7:45:54 PM ******/
ALTER TABLE [dbo].[Profiles] ADD UNIQUE NONCLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[GenreLocalization]  WITH CHECK ADD FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[GenreLocalization]  WITH CHECK ADD  CONSTRAINT [FK__GenreLocaliz__Id__5629CD9C] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genres] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GenreLocalization] CHECK CONSTRAINT [FK__GenreLocaliz__Id__5629CD9C]
GO
ALTER TABLE [dbo].[MovieLocalization]  WITH CHECK ADD FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[MovieLocalization]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[MoviePersonsJunction]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[MoviePersonsJunction]  WITH CHECK ADD  CONSTRAINT [FK__MoviePers__Perso__34C8D9D1] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Persons] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MoviePersonsJunction] CHECK CONSTRAINT [FK__MoviePers__Perso__34C8D9D1]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK__Movies__Director__35BCFE0A] FOREIGN KEY([DirectorId])
REFERENCES [dbo].[Persons] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK__Movies__Director__35BCFE0A]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK__Movies__GenreId__36B12243] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genres] ([Id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK__Movies__GenreId__36B12243]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD FOREIGN KEY([PhotoId])
REFERENCES [dbo].[Photos] ([Id])
GO
ALTER TABLE [dbo].[PersonLocalization]  WITH CHECK ADD FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[PersonLocalization]  WITH CHECK ADD  CONSTRAINT [FK__PersonLoc__Perso__398D8EEE] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Persons] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonLocalization] CHECK CONSTRAINT [FK__PersonLoc__Perso__398D8EEE]
GO
ALTER TABLE [dbo].[Persons]  WITH CHECK ADD  CONSTRAINT [FK__Persons__PhotoId__3B75D760] FOREIGN KEY([PhotoId])
REFERENCES [dbo].[Photos] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Persons] CHECK CONSTRAINT [FK__Persons__PhotoId__3B75D760]
GO
ALTER TABLE [dbo].[Profiles]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[Seances]  WITH CHECK ADD FOREIGN KEY([HallId])
REFERENCES [dbo].[Halls] ([Id])
GO
ALTER TABLE [dbo].[Seances]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[Sectors]  WITH CHECK ADD FOREIGN KEY([HallId])
REFERENCES [dbo].[Halls] ([Id])
GO
ALTER TABLE [dbo].[Sectors]  WITH CHECK ADD FOREIGN KEY([SectorTypeId])
REFERENCES [dbo].[SectorTypes] ([Id])
GO
ALTER TABLE [dbo].[SecurityToken]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[TicketPreOrders]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[TicketPreOrders]  WITH CHECK ADD FOREIGN KEY([SeanceId])
REFERENCES [dbo].[Seances] ([Id])
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([SeanceId])
REFERENCES [dbo].[Seances] ([Id])
GO
USE [master]
GO
ALTER DATABASE [CinemaDatabase] SET  READ_WRITE 
GO
