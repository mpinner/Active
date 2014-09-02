// Simple example effect:
// Draws a noise pattern modulated by an expanding sine wave.

#include <math.h>
#include "lib/color.h"
#include "lib/effect.h"
#include "lib/effect_runner.h"
#include "lib/noise.h"

class MyEffect : public Effect
{
public:
    MyEffect()
        : cycle (0) {}

    float cycle;
    float theIndex;


    virtual void beginFrame(const FrameInfo &f)
    {
        const float speed = 9.3;
        cycle = fmodf(cycle + f.timeDelta * speed, 24);

        theIndex = ((int)cycle) % 24;
        theIndex -= 12;
        theIndex /= 5.0;
    }

    virtual void shader(Vec3& rgb, const PixelInfo &p) const
    {



       // float distance = len(p.point);
     //   float wave = sinf(0.7 * p.point[2] - cycle) + noise3(p.point);


        for (int i = 0; i < 3; i++) {
            if (theIndex == p.point[2]) {
                rgb[i] =  (p.point[1] + 2.2);
            } else {
                rgb[i] =  1.0;
            }
        }    

        return;
    }

    virtual void debug(const DebugInfo& d)
    {
        fprintf(stderr, "\t[fixed] cycle = %f , theIndex = %f\n", cycle, theIndex);
        return;
    }

    virtual void endFrame(const FrameInfo &f) {
                usleep(1e3);

    }

};




int main(int argc, char **argv)
{
    EffectRunner r;

    MyEffect e;
    r.setEffect(&e);

    // Defaults, overridable with command line options
    r.setMaxFrameRate(30);
    r.setLayout("../layouts/grid32x16z.json");

    return r.main(argc, argv);
}
