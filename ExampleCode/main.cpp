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
  myEM.color(100, 100);
  WritePFM(argv[2], width, height, numComponents, img_in);

  return 0;
}
