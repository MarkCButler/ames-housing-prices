library(purrr)
library(stringr)

# This file was created by modifying the file data_description.txt that came
# with the data set.  Two vim macros were used to convert the file to
# an R command that generates a list of variable descriptions.

# To convert the text file using vim, first do the following search:
#
# /^\s*$
#
# which finds lines containing only white space.  Once this search has been
# performed, the command n in a macro will move to the next blank line.
#
# Two different macros are needed, one for categorical variables (which
# include blank lines both before and after the list of categories) and
# numerical variables (which are simply followed by a single blank line).  The
# two macros
#
# ve"ayi^Ra = '^[nnkA',^[jdd
#
# ve"ayi^Ra = '^[nkA',^[jdd
#
# can be run with the cursor at the beginning of a categorical or numerical
# variable name, respectively, and each leaves the cursor at the beginning of
# the next variable name.  (Note that in these macros, ^R and ^[ correspond to
# ctrl-r to ctrl-[ respectively.)
#
# After the macros are used to convert the text descriptions to an argument
# that can be passed to to the R command list, a little manual cleanup is
# needed, e.g., because the variable 1stFlrSF is not a valid name for a list
# element.

variable_descriptions <- list(
    MSSubClass = 'MSSubClass: Identifies the type of dwelling involved in the sale.

        20      1-STORY 1946 & NEWER ALL STYLES
        30      1-STORY 1945 & OLDER
        40      1-STORY W/FINISHED ATTIC ALL AGES
        45      1-1/2 STORY - UNFINISHED ALL AGES
        50      1-1/2 STORY FINISHED ALL AGES
        60      2-STORY 1946 & NEWER
        70      2-STORY 1945 & OLDER
        75      2-1/2 STORY ALL AGES
        80      SPLIT OR MULTI-LEVEL
        85      SPLIT FOYER
        90      DUPLEX - ALL STYLES AND AGES
       120      1-STORY PUD (Planned Unit Development) - 1946 & NEWER
       150      1-1/2 STORY PUD - ALL AGES
       160      2-STORY PUD - 1946 & NEWER
       180      PUD - MULTILEVEL - INCL SPLIT LEV/FOYER
       190      2 FAMILY CONVERSION - ALL STYLES AND AGES',
    MSZoning = 'MSZoning: Identifies the general zoning classification of the sale.

       A        Agriculture
       C        Commercial
       FV       Floating Village Residential
       I        Industrial
       RH       Residential High Density
       RL       Residential Low Density
       RP       Residential Low Density Park
       RM       Residential Medium Density',
    LotFrontage = 'LotFrontage: Linear feet of street connected to property',
    LotArea = 'LotArea: Lot size in square feet',
    Street = 'Street: Type of road access to property

       Grvl     Gravel
       Pave     Paved',
    Alley = 'Alley: Type of alley access to property

       Grvl     Gravel
       Pave     Paved
       None     No alley access',
    LotShape = 'LotShape: General shape of property

       Reg      Regular
       IR1      Slightly irregular
       IR2      Moderately Irregular
       IR3      Irregular',
    LandContour = 'LandContour: Flatness of the property

       Lvl      Near Flat/Level
       Bnk      Banked - Quick and significant rise from street grade to building
       HLS      Hillside - Significant slope from side to side
       Low      Depression',
    Utilities = 'Utilities: Type of utilities available

       AllPub   All public Utilities (E,G,W,& S)
       NoSewr   Electricity, Gas, and Water (Septic Tank)
       NoSeWa   Electricity and Gas Only
       ELO      Electricity only',
    LotConfig = 'LotConfig: Lot configuration

       Inside   Inside lot
       Corner   Corner lot
       CulDSac  Cul-de-sac
       FR2      Frontage on 2 sides of property
       FR3      Frontage on 3 sides of property',
    LandSlope = 'LandSlope: Slope of property

       Gtl      Gentle slope
       Mod      Moderate Slope
       Sev      Severe Slope',
    Neighborhood = 'Neighborhood: Physical locations within Ames city limits

       Blmngtn  Bloomington Heights
       Blueste  Bluestem
       BrDale   Briardale
       BrkSide  Brookside
       ClearCr  Clear Creek
       CollgCr  College Creek
       Crawfor  Crawford
       Edwards  Edwards
       Gilbert  Gilbert
       IDOTRR   Iowa DOT and Rail Road
       MeadowV  Meadow Village
       Mitchel  Mitchell
       Names    North Ames
       NoRidge  Northridge
       NPkVill  Northpark Villa
       NridgHt  Northridge Heights
       NWAmes   Northwest Ames
       OldTown  Old Town
       SWISU    South & West of Iowa State University
       Sawyer   Sawyer
       SawyerW  Sawyer West
       Somerst  Somerset
       StoneBr  Stone Brook
       Timber   Timberland
       Veenker  Veenker',
    Condition1 = 'Condition1: Proximity to various conditions

       Artery   Adjacent to arterial street
       Feedr    Adjacent to feeder street
       Norm     Normal
       RRNn     Within 200\' of North-South Railroad
       RRAn     Adjacent to North-South Railroad
       PosN     Near positive off-site feature--park, greenbelt, etc.
       PosA     Adjacent to postive off-site feature
       RRNe     Within 200\' of East-West Railroad
       RRAe     Adjacent to East-West Railroad',
    Condition2 = 'Condition2: Proximity to various conditions (if more than one is present)

       Artery   Adjacent to arterial street
       Feedr    Adjacent to feeder street
       Norm     Normal
       RRNn     Within 200\' of North-South Railroad
       RRAn     Adjacent to North-South Railroad
       PosN     Near positive off-site feature--park, greenbelt, etc.
       PosA     Adjacent to postive off-site feature
       RRNe     Within 200\' of East-West Railroad
       RRAe     Adjacent to East-West Railroad',
    BldgType = 'BldgType: Type of dwelling

       1Fam     Single-family Detached
       2FmCon   Two-family Conversion; originally built as one-family dwelling
       Duplx    Duplex
       TwnhsE   Townhouse End Unit
       TwnhsI   Townhouse Inside Unit',
    HouseStyle = 'HouseStyle: Style of dwelling

       1Story   One story
       1.5Fin   One and one-half story: 2nd level finished
       1.5Unf   One and one-half story: 2nd level unfinished
       2Story   Two story
       2.5Fin   Two and one-half story: 2nd level finished
       2.5Unf   Two and one-half story: 2nd level unfinished
       SFoyer   Split Foyer
       SLvl     Split Level',
    OverallQual = 'OverallQual: Rates the overall material and finish of the house

       10       Very Excellent
       9        Excellent
       8        Very Good
       7        Good
       6        Above Average
       5        Average
       4        Below Average
       3        Fair
       2        Poor
       1        Very Poor',
    OverallCond = 'OverallCond: Rates the overall condition of the house

       10       Very Excellent
       9        Excellent
       8        Very Good
       7        Good
       6        Above Average
       5        Average
       4        Below Average
       3        Fair
       2        Poor
       1        Very Poor',
    YearBuilt = 'YearBuilt: Original construction date',
    YearRemodAdd = paste0(
        'YearRemodAdd: Remodel date (same as construction date if no remodeling or\n',
        '              additions)'
    ),
    RoofStyle = 'RoofStyle: Type of roof

       Flat     Flat
       Gable    Gable
       Gambrel  Gabrel (Barn)
       Hip      Hip
       Mansard  Mansard
       Shed     Shed',
    RoofMatl = 'RoofMatl: Roof material

       ClyTile  Clay or Tile
       CompShg  Standard (Composite) Shingle
       Membran  Membrane
       Metal    Metal
       Roll     Roll
       Tar&Grv  Gravel & Tar
       WdShake  Wood Shakes
       WdShngl  Wood Shingles',
    Exterior1st = 'Exterior1st: Exterior covering on house

       AsbShng  Asbestos Shingles
       AsphShn  Asphalt Shingles
       BrkComm  Brick Common
       BrkFace  Brick Face
       CBlock   Cinder Block
       CemntBd  Cement Board
       HdBoard  Hard Board
       ImStucc  Imitation Stucco
       MetalSd  Metal Siding
       Other    Other
       Plywood  Plywood
       PreCast  PreCast
       Stone    Stone
       Stucco   Stucco
       VinylSd  Vinyl Siding
       Wd Sdng  Wood Siding
       WdShing  Wood Shingles',
    Exterior2nd = 'Exterior2nd: Exterior covering on house (if more than one material)

       AsbShng  Asbestos Shingles
       AsphShn  Asphalt Shingles
       BrkComm  Brick Common
       BrkFace  Brick Face
       CBlock   Cinder Block
       CemntBd  Cement Board
       HdBoard  Hard Board
       ImStucc  Imitation Stucco
       MetalSd  Metal Siding
       Other    Other
       Plywood  Plywood
       PreCast  PreCast
       Stone    Stone
       Stucco   Stucco
       VinylSd  Vinyl Siding
       Wd Sdng  Wood Siding
       WdShing  Wood Shingles',
    MasVnrType = 'MasVnrType: Masonry veneer type

       BrkCmn   Brick Common
       BrkFace  Brick Face
       CBlock   Cinder Block
       None     None
       Stone    Stone',
    MasVnrArea = 'MasVnrArea: Masonry veneer area in square feet',
    ExterQual = 'ExterQual: Evaluates the quality of the material on the exterior

       Ex       Excellent
       Gd       Good
       TA       Average/Typical
       Fa       Fair
       Po       Poor',
    ExterCond = 'ExterCond: Evaluates the present condition of the material on the exterior

       Ex       Excellent
       Gd       Good
       TA       Average/Typical
       Fa       Fair
       Po       Poor',
    Foundation = 'Foundation: Type of foundation

       BrkTil   Brick & Tile
       CBlock   Cinder Block
       PConc    Poured Contrete
       Slab     Slab
       Stone    Stone
       Wood     Wood',
    BsmtQual = 'BsmtQual: Evaluates the height of the basement

       Ex       Excellent (100+ inches)
       Gd       Good (90-99 inches)
       TA       Typical (80-89 inches)
       Fa       Fair (70-79 inches)
       Po       Poor (<70 inches
       NB       No Basement',
    BsmtCond = 'BsmtCond: Evaluates the general condition of the basement

       Ex       Excellent
       Gd       Good
       TA       Typical - slight dampness allowed
       Fa       Fair - dampness or some cracking or settling
       Po       Poor - Severe cracking, settling, or wetness
       NB       No Basement',
    BsmtExposure = 'BsmtExposure: Refers to walkout or garden level walls

       Gd       Good Exposure
       Av       Average Exposure (split levels or foyers typically score average
                or above)
       Mn       Mimimum Exposure
       No       No Exposure
       NB       No Basement',
    BsmtFinType1 = 'BsmtFinType1: Rating of basement finished area

       GLQ      Good Living Quarters
       ALQ      Average Living Quarters
       BLQ      Below Average Living Quarters
       Rec      Average Rec Room
       LwQ      Low Quality
       Unf      Unfinshed
       NB       No Basement',
    BsmtFinSF1 = 'BsmtFinSF1: Type 1 finished square feet',
    BsmtFinType2 = 'BsmtFinType2: Rating of basement finished area (if multiple types)

       GLQ      Good Living Quarters
       ALQ      Average Living Quarters
       BLQ      Below Average Living Quarters
       Rec      Average Rec Room
       LwQ      Low Quality
       Unf      Unfinshed
       NB       No Basement',
    BsmtFinSF2 = 'BsmtFinSF2: Type 2 finished square feet',
    BsmtUnfSF = 'BsmtUnfSF: Unfinished square feet of basement area',
    TotalBsmtSF = 'TotalBsmtSF: Total square feet of basement area',
    Heating = 'Heating: Type of heating

       Floor    Floor Furnace
       GasA     Gas forced warm air furnace
       GasW     Gas hot water or steam heat
       Grav     Gravity furnace
       OthW     Hot water or steam heat other than gas
       Wall     Wall furnace',
    HeatingQC = 'HeatingQC: Heating quality and condition

       Ex       Excellent
       Gd       Good
       TA       Average/Typical
       Fa       Fair
       Po       Poor',
    CentralAir = 'CentralAir: Central air conditioning

       N        No
       Y        Yes',
    Electrical = 'Electrical: Electrical system

       SBrkr    Standard Circuit Breakers & Romex
       FuseA    Fuse Box over 60 AMP and all Romex wiring (Average)
       FuseF    60 AMP Fuse Box and mostly Romex wiring (Fair)
       FuseP    60 AMP Fuse Box and mostly knob & tube wiring (poor)
       Mix      Mixed',
    FirstFlrSF = 'FirstFlrSF: First Floor square feet',
    SecondFlrSF = 'SecondFlrSF: Second floor square feet',
    LowQualFinSF = 'LowQualFinSF: Low quality finished square feet (all floors)',
    GrLivArea = 'GrLivArea: Above grade (ground) living area square feet',
    BsmtFullBath = 'BsmtFullBath: Basement full bathrooms',
    BsmtHalfBath = 'BsmtHalfBath: Basement half bathrooms',
    FullBath = 'FullBath: Full bathrooms above grade',
    HalfBath = 'HalfBath: Half baths above grade',
    BedroomAbvGr = 'BedroomAbvGr: Bedrooms above grade (does NOT include basement bedrooms)',
    KitchenAbvGr = 'KitchenAbvGr: Kitchens above grade',
    KitchenQual = 'KitchenQual: Kitchen quality

       Ex       Excellent
       Gd       Good
       TA       Typical/Average
       Fa       Fair
       Po       Poor',
    TotRmsAbvGrd = 'TotRmsAbvGrd: Total rooms above grade (does not include bathrooms)',
    Functional = 'Functional: Home functionality (Assume typical unless deductions are warranted)

       Typ      Typical Functionality
       Min1     Minor Deductions 1
       Min2     Minor Deductions 2
       Mod      Moderate Deductions
       Maj1     Major Deductions 1
       Maj2     Major Deductions 2
       Sev      Severely Damaged
       Sal      Salvage only',
    Fireplaces = 'Fireplaces: Number of fireplaces',
    FireplaceQu = 'FireplaceQu: Fireplace quality

       Ex       Excellent - Exceptional Masonry Fireplace
       Gd       Good - Masonry Fireplace in main level
       TA       Average - Prefabricated Fireplace in main living area
                or Masonry Fireplace in basement
       Fa       Fair - Prefabricated Fireplace in basement
       Po       Poor - Ben Franklin Stove
       No       No Fireplace',
    GarageType = 'GarageType: Garage location

       2Types   More than one type of garage
       Attchd   Attached to home
       Basment  Basement Garage
       BuiltIn  Built-In (Garage part of house - typically has room above garage)
       CarPort  Car Port
       Detchd   Detached from home
       None     No Garage',
    GarageYrBlt = 'GarageYrBlt: Year garage was built',
    GarageFinish = 'GarageFinish: Interior finish of the garage

       Fin      Finished
       RFn      Rough Finished
       Unf      Unfinished
       No       No Garage',
    GarageCars = 'GarageCars: Size of garage in car capacity',
    GarageArea = 'GarageArea: Size of garage in square feet',
    GarageQual = 'GarageQual: Garage quality

       Ex       Excellent
       Gd       Good
       TA       Typical/Average
       Fa       Fair
       Po       Poor
       No       No Garage',
    GarageCond = 'GarageCond: Garage condition

       Ex       Excellent
       Gd       Good
       TA       Typical/Average
       Fa       Fair
       Po       Poor
       No       No Garage',
    PavedDrive = 'PavedDrive: Paved driveway

       Y        Paved
       P        Partial Pavement
       N        Dirt/Gravel',
    WoodDeckSF = 'WoodDeckSF: Wood deck area in square feet',
    OpenPorchSF = 'OpenPorchSF: Open porch area in square feet',
    EnclosedPorch = 'EnclosedPorch: Enclosed porch area in square feet',
    ThreeSsnPorch = 'ThreeSsnPorch: Three season porch area in square feet',
    ScreenPorch = 'ScreenPorch: Screen porch area in square feet',
    PoolArea = 'PoolArea: Pool area in square feet',
    PoolQC = 'PoolQC: Pool quality

       Ex       Excellent
       Gd       Good
       TA       Average/Typical
       Fa       Fair
       No       No Pool',
    Fence = 'Fence: Fence quality

       GdPrv    Good Privacy
       MnPrv    Minimum Privacy
       GdWo     Good Wood
       MnWw     Minimum Wood/Wire
       No       No Fence',
    MiscFeature = 'MiscFeature: Miscellaneous feature not covered in other categories

       Elev     Elevator
       Gar2     2nd Garage (if not described in garage section)
       Othr     Other
       Shed     Shed (over 100 SF)
       TenC     Tennis Court
       None     None',
    MiscVal = 'MiscVal: $Value of miscellaneous feature',
    MoSold = 'MoSold: Month Sold (MM)',
    YrSold = 'YrSold: Year Sold (YYYY)',
    SaleType = 'SaleType: Type of sale

       WD       Warranty Deed - Conventional
       CWD      Warranty Deed - Cash
       VWD      Warranty Deed - VA Loan
       New      Home just constructed and sold
       COD      Court Officer Deed/Estate
       Con      Contract 15% Down payment regular terms
       ConLw    Contract Low Down payment and low interest
       ConLI    Contract Low Interest
       ConLD    Contract Low Down
       Oth      Other',
    SaleCondition = 'SaleCondition: Condition of sale

       Normal   Normal Sale
       Abnorml  Abnormal Sale -  trade, foreclosure, short sale
       AdjLand  Adjoining Land Purchase
       Alloca   Allocation - two linked properties with separate deeds,
                typically condo with a garage unit
       Family   Sale between family members
       Partial  Home was not completed when last assessed
                (associated with New Homes)',
    # Include a description of the sales price in order to simplify plot generation.
    SalesPrice = 'Sale Price',
    NoBasement = 'NoBasement:  Does the house have a basement'
)

# Define short descriptions by extracting the one-line summaries.
short_descriptions <- map(
    variable_descriptions,
    ~ str_trim(str_extract(., '^.*\\n\\n'), side = 'right'
))
short_descriptions <- ifelse(
    is.na(short_descriptions),
    variable_descriptions,
    short_descriptions
)

# Define a comment (by default an empty string) for each predictor.
comments <- map(variable_descriptions, '')
comments['GrLivArea'] <- 'The log of sale price varies linearly with the log of living area.'
comments['Functional'] <- paste0(
    'Any drop below typical functionality causes a drop in price, but\n',
    '    the data does not show a clear dependence of price on the level\n',
    '    of functionality loss.')
comments['Condition1'] <- paste0(
    'Being near or adjacent to a park, greenbelt, etc gives a boost\n',
    '    in price, while being adjacent to a feeder street or arterial street\n',
    '    gives a drop in price.  Research is needed to clarify the way\n',
    '    in which proximity to railroads affects price.')
comments['MSZoning'] <- paste0(
    'Most houses are in a low-density residential zone.  Houses in a\n',
    '    "Floating Village" residential zone get a boost in price, while\n',
    '    houses in medium- or high-density residential zones get a price\n',
    '    penalty.  Houses in commercial zones get a substantial price penalty.')
comments['SaleCondition'] <- paste0(
    'Houses with an abnormal sale take a price penalty, while new homes\n',
    '    in the Partial category have a price boost.')
