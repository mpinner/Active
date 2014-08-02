#include "lib/effect_runner.h"
//#include "lib/BlackLib.h"
#include "black-rings.h"


int main(int argc, char **argv)
{
  //  BlackADC analog(AIN4);// initialization analog input
    //    analog.getNumericValue();
    RingsEffect e("data/glass.png");
    

    EffectRunner r;
    r.setEffect(&e);

    r.setLayout("../layouts/grid32x16z.json");
    return r.main(argc, argv);
}
