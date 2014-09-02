// Snow  effect:

#include <math.h>
#include "lib/color.h"
#include "lib/effect.h"
#include "lib/effect_runner.h"
#include "lib/noise.h"

class SnowEffect : public Effect
{
public:
    SnowEffect()
        : cycle (0) {}

    float cycle;

    virtual void beginFrame(const FrameInfo &f)
    {
        const float speed = 1.5;
        cycle = fmodf(cycle + f.timeDelta * speed, 2 * M_PI);
    }

    virtual void shader(Vec3& rgb, const PixelInfo &p) const
    {

        float theIndex;
 
        theIndex = ((int)cycle) % 24;
        theIndex -= 12;
        theIndex /= 5.0;

       // float distance = len(p.point);
        float wave = sinf(0.7 * p.point[2] - cycle) + noise3(p.point);


    for (int i = 0; i < 3; i++) {
            rgb[i] =  wave;
        }   

    

       return;
    }

    virtual void debug(const DebugInfo& d)
    {
        fprintf(stderr, "\t[snow] cycle = %f \n", cycle);
        return;
    }

    virtual void endFrame(const FrameInfo &f) {
                usleep(1e3);

    }

};



