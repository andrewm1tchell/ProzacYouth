Prozac Youth 

https://andrewmitchell-art.xyz/art/prozacyouth.php?mode=0

![image](https://github.com/user-attachments/assets/f0ff0c7d-6f85-4dde-a4e8-d1277a702ced)


There are 5 contracts involved in Prozac Youth.

Main Manifold contract containing the NFT:
0x7e5029837a43c547cdcea2107a1e07e30d68c6d6

ProzacYouth Contract containing the Onchain TokenURI and Onchain preview image:
0xd3fD133460a4E8292CB7C1aA7984704B23857d59

ProzacYouthUtils containing the Onchain entries:
0x75122C1ED275ce3D00f34AE592928bD7180f928C

ProzacYouthEngine contracts 1 and 2 for building the animation_url:
0xBf13AFb925B6f9033A2b1988a5a9504b3Cb83275
0xf272ff92c518e793450002a65ef2bbed50e95743

How does the TokenURI work?
TokenURI() is called -> Manifold Contract -> Prozac Youth Contract 
This contracts creates a JSON object with the image, animationUrl, description, and title.
To get the animationUrl, we utilize ProzacYouthEngine1 and ProzacYouthEngine2. 
The ProzacYouthEngine1 contract calls the ProzacYouthUtils contract to get the Entries.

All of the contracts work together to build out the tokenURI JSON object, which is encoded into Base 64 onchain.

