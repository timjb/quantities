module Quantities.Screen

import Quantities
import Quantities.SIBaseQuantities
import Quantities.ImperialUnits
import Quantities.SIBaseUnits

ScreenLength : Dimension
ScreenLength = MkDimension "ScreenLength"

pixel : ElemUnit ScreenLength
pixel = MkElemUnit "px" 1
px : ElemUnit ScreenLength
px = pixel

ScreenArea : Quantity
ScreenArea = ScreenLength ^ 2
ScreenEstate : Quantity
ScreenEstate = ScreenArea

ScreenResolution : Quantity
ScreenResolution = ScreenLength </> Length

pixelPerCentimetre : ElemUnit ScreenResolution
pixelPerCentimetre = < one "ppcm" equals 1 (pixel <//> centimetre) >
pixelPerCentimeter : ElemUnit ScreenResolution
pixelPerCentimeter = pixelPerCentimetre
ppcm : ElemUnit ScreenResolution
ppcm = pixelPerCentimetre

pixelPerInch : ElemUnit ScreenResolution
pixelPerInch = < one "ppi" equals 1 (pixel <//> inch) >
ppi : ElemUnit ScreenResolution
ppi = pixelPerInch
