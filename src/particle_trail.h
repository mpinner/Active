// Simple particle system example for C++.

#pragma once

#include <math.h>
#include "lib/color.h"
#include "lib/effect.h"
#include "lib/particle.h"

class ParticleTrailEffect : public ParticleEffect
{
public:
    ParticleTrailEffect()
        : angle1(0), angle2(0), baseHue(0)
    {}

    float angle1;
    float angle2;
    float angle3;

    float baseHue;

    virtual void beginFrame(const FrameInfo &f)
    {
        const float tailLength = 4.0f;
	//  const float speed = 0.01f;  //SLOW
        const float speed = 0.29f;  //FAST
        const float lfoRatio = 0.15f;
        const float notLfoRatio = 0.30f;
        const float hueRate = 0.1f;
        const float brightness = 40.0f;
        const unsigned numParticles = 15;

        // Low frequency oscillators
        angle1 = fmodf(angle1 + f.timeDelta * speed, 2 * M_PI);
        angle2 = fmodf(angle2 + f.timeDelta * speed * lfoRatio, 2 * M_PI);
        angle3 = fmodf(angle3 + f.timeDelta * speed * notLfoRatio, 2 * M_PI);
        baseHue = fmodf(baseHue + f.timeDelta * speed * hueRate, 1.0f);

        appearance.resize(numParticles);
        for (unsigned i = 0; i < numParticles; i++) {
            float s = float(i) / numParticles;
            float tail = s * tailLength;

            float radius = 0.2 + 2.0 * s;
            float x = radius * cos(angle1 + tail) * 3.0 + 1.0;
            float y = radius * sin(angle1 + tail + 12.0 * sin(angle2 + tail * lfoRatio));
            float z = radius * sin(angle3 + tail);   
            float hue = baseHue + s * 0.4;

            ParticleAppearance& p = appearance[i];
            p.point = Vec3(x, y, z);
            p.intensity = (brightness / numParticles) * s;
            p.radius = 0.1 + 1.2f * s;  //MADE BIG
            hsv2rgb(p.color, hue, 0.5, 1.0);
        }

        ParticleEffect::beginFrame(f);
    }
};
