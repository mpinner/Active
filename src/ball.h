// Ball effect:
// Draws a noise pattern modulated by an expanding sine wave.

#include <math.h>
#include "lib/color.h"
#include "lib/effect.h"
#include "lib/effect_runner.h"
#include "lib/noise.h"

class BallEffect : public Effect
{
public:
    BallEffect()
        : cycle (0) {}

    float cycle;

    virtual void beginFrame(const FrameInfo &f)
    {
        const float speed = 1.0;
        cycle = fmodf(cycle + f.timeDelta * speed, 2 * M_PI);
    }

    virtual void shader(Vec3& rgb, const PixelInfo &p) const
    {
        float distance = len(p.point);
        float wave = sinf(3.0 * distance - cycle) ; //+ noise3(p.point);
        hsv2rgb(rgb, 0.2, 0.3, wave);
    }
};
