/*//////////////////////////////////////////////////////////////////////////
Author: Abhijeet Ghosh
Year: 2013
//////////////////////////////////////////////////////////////////////////*/
#include "util.h"

using namespace std;

int main(int argc, char** argv)
{
  if(argc < 2)
  {
    cout<<"Too few arguments! .... exiting."<<endl;
    return 0;
  }        

  unsigned int width, height, numComponents;
  float* img_in = loadPFM(argv[1], width, height, numComponents);
  EM myEM(img_in, width, height, numComponents);
  float* sphere_in = loadPFM(argv[2], width, height, numComponents);
  
  renderSphereWithSample(myEM, sphere_in, width, height, numComponents, 128);
  WritePFM(argv[3], width, height, numComponents, sphere_in);

  return 0;
}
