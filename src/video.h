// images for movie frames

#pragma once

#include "lib/color.h"
#include "lib/effect.h"
#include "lib/texture.h"
#include "lib/tinydir.h"


class VideoEffect : public Effect
{
public:

    Texture * dot;

    // should i leave this open?
    const char *directoryName;
    int imageIndex;
    int maxImageIndex;

    float videoFrame;
    int loadedFrame;

    VideoEffect(const char *directory) : 
        imageIndex(0),
        maxImageIndex(0),
        videoFrame(0),
        loadedFrame(-1)

    {
        directoryName = directory;
        dot = new Texture();

        // load directory
        tinydir_dir dir;
        if (tinydir_open(&dir, directoryName) == -1)
        {
            perror("Error opening directory");
            tinydir_close(&dir);
        }

        // count pngs 
    while (dir.has_next) {
        tinydir_file file;
        if (tinydir_readfile(&dir, &file) == -1)
        {
            perror("Error getting file");
             tinydir_close(&dir);
        }

        printf("%s", file.name);
        if (file.is_dir)
        {
            printf("/");
        } 
        printf("\n");

        if (!strcmp(file.extension, "png")) {
            printf("found image %s\n", file.name);
            /*
            printf("Path: %s\nName: %s\nExtension: %s\nIs dir? %s\nIs regular file? %s\n",
            file.path, file.name, file.extension,
            file.is_dir?"yes":"no", file.is_reg?"yes":"no");
            */

          //  tmpImage = new DotEffect(file.path);
          //  DotEffect e("data/dot.png");
          //  img[imageIndex] = tmpImage;
          //  mixer.add(img[imageIndex]);
         //   mixer.add(tmpImage);
              maxImageIndex++;
        }

        tinydir_next(&dir);
    }
    tinydir_close(&dir);

        printf("found %d pngs: \n", maxImageIndex);

    }

    inline void loadFrame(int currentFrame) const
    {
        if (currentFrame > maxImageIndex) {
            printf("cannot load frame %d : \n", currentFrame);
            return;

        }

        // debug
        //debug
              //printf("loading frame %d : \n", currentFrame);

 // load directory    
        tinydir_dir dir;

        if (tinydir_open(&dir, directoryName) == -1)
        {
            perror("Error opening directory");
            tinydir_close(&dir);
        }

    
// find file

        for (int currentFile = 0; dir.has_next; tinydir_next(&dir)) {
            tinydir_file file;
            if (tinydir_readfile(&dir, &file) == -1)
            {
                perror("Error getting file");
                tinydir_close(&dir);
            }

            //debug
              //printf("%s", file.name);
            if (file.is_dir)
            {
             //debug
              //   printf("/");
            } 
            //debug
              //printf("\n");

            if (!strcmp(file.extension, "png")) {
              //debug
              //  printf("found image %s at index %d\n", file.name, currentFile);

                if (currentFile == currentFrame) {
                    dot->load(file.path);
                }
          
              //  tmpImage = new DotEffect(file.path);
              //  DotEffect e("data/dot.png");
              //  img[imageIndex] = tmpImage;
              //  mixer.add(img[imageIndex]);
             //   mixer.add(tmpImage);
                  currentFile++;
            }
        }
        tinydir_close(&dir);



        return;
    }
    
    virtual void beginFrame(const FrameInfo &f)
    {



        // load current Frame
//dot.load(file.path)
        
//      const float speed = 1.0; // SLOW
        const float speed = 1.01; // FAST

        videoFrame = fmod(videoFrame + f.timeDelta * speed, maxImageIndex);

        int currentFrame = ((int) videoFrame);
        if (currentFrame != loadedFrame) {
            loadFrame(currentFrame);
        }

        return;  
    }


    virtual void shader(Vec3& rgb, const PixelInfo &p) const
    {
        // Project onto the XZ plane
//        Vec2 plane = Vec2(p.point[0], p.point[2]*-1.0);
   Vec2 plane = Vec2(p.point[0]*-0.42, p.point[2]*1.05);

// rotate this
//        plane

        // Moving dot
        Vec2 position =  Vec2( 1.0, 1.0);

        // Texture geometry
        Vec2 center(0.59, 0.47);
        float size = 5.0;

    //    rgb = dot.sample( (plane + position) / size + center );
        rgb = dot->sample( (plane) / size + center );

//        rgb = dot.sample( (plane - position) / size + center );
    }

};
