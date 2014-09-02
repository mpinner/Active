// images for movie frames

#pragma once

#include "lib/color.h"
#include "lib/effect.h"
#include "lib/texture.h"

class ImageEffect : public Effect
{
public:
    ImageEffect(const char *filename)
        : dot(filename),
          angle1(2*M_PI), angle2(0), angle3(0)
    {}

    Texture dot;

    float angle1;
    float angle2;
    float angle3;

    virtual void beginFrame(const FrameInfo &f)
    {
        
//      const float speed = 0.01; // SLOW
    const float speed = 1.01; // FAST

        // Several bounded state variables, rotating at different rates
     ///*
        angle1 = fmodf(angle1 + f.timeDelta * speed, 2 * M_PI);
        angle2 = fmodf(angle2 + f.timeDelta * speed * 0.2f, 2 * M_PI);
        angle3 = fmodf(angle3 + f.timeDelta * speed * 0.7f, 2 * M_PI);
//*/
        // Several bounded state variables, rotating at different rates
   /*
        angle1 = fmodf(angle1  * speed, 2 * M_PI);
        angle2 = fmodf(angle2  * speed , 2 * M_PI);
        angle3 = fmodf(angle3 + f.timeDelta  * speed , 2 * M_PI);
    */
    }

    virtual void shader(Vec3& rgb, const PixelInfo &p) const
    {
        // Project onto the XZ plane
//        Vec2 plane = Vec2(p.point[0], p.point[2]*-1.0);
   Vec2 plane = Vec2(p.point[0]*-0.4, p.point[2]*-1.0);

// rotate this
//        plane

        // Moving dot
        Vec2 position = 1.0 * Vec2( sinf(angle1)*4.0+1.0, cosf(angle1 + sin(angle2)) );

        // Texture geometry
        Vec2 center(0.6, 0.4);
        float size = 5.0;

    //    rgb = dot.sample( (plane + position) / size + center );
        rgb = dot.sample( (plane) / size + center );

//        rgb = dot.sample( (plane - position) / size + center );
    }

};
