module Quantities.Screen

import Quantities.Core
import Quantities.SIBaseQuantities
import Quantities.ImperialUnits
import Quantities.SIBaseUnits

ScreenLength : Dimension
ScreenLength = MkDimension "ScreenLength"

Pixel : ElemUnit ScreenLength
Pixel = MkElemUnit "px" 1
Px : ElemUnit ScreenLength
Px = Pixel

ScreenArea : Quantity
ScreenArea = ScreenLength ^ 2
ScreenEstate : Quantity
ScreenEstate = ScreenArea

ScreenResolution : Quantity
ScreenResolution = ScreenLength </> Length

PixelPerCentimetre : ElemUnit ScreenResolution
PixelPerCentimetre = < one "ppcm" equals 1 (Pixel <//> Centimetre) >
PixelPerCentimeter : ElemUnit ScreenResolution
PixelPerCentimeter = PixelPerCentimetre
Ppcm : ElemUnit ScreenResolution
Ppcm = PixelPerCentimetre

PixelPerInch : ElemUnit ScreenResolution
PixelPerInch = < one "ppi" equals 1 (Pixel <//> Inch) >
Ppi : ElemUnit ScreenResolution
Ppi = PixelPerInch
