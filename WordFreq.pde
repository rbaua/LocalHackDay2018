import java.util.*;
class Node{
   String input;
   int freq;
   int r, g, b;
   
   public Node(String inputin, int rin, int gin, int bin, int freq){
     input = inputin;
     r = rin;
     g = gin;
     b = bin;
     freq = 0;
   }
   
   public void darken(){
     float tintFactor = .25;
     r = int(r + (255 - r) * tintFactor);
     g = int(g + (255 - g) * tintFactor);
     b = int(b + (255 - b) * tintFactor);
   }
   
   public void upFreq(){
     freq++;
   }
   
   public String getWord(){
     return input; 
   }
   
   public int getFreq(){
     return freq;
   }
}

ArrayList<Node> inputs = new ArrayList<Node>();


//Search Function to update all values
int search(String word){
  Node output = null;
  for (Node object: inputs){
    if (object.input.equals(word)){
      object.freq = object.freq + 1;
      
      //Call darken function based on rule
      object.darken();
      
      output = object;
    }
  }
  if(output == null){
    return -1;
  }
  else{
    return inputs.lastIndexOf(output);
  }
}

void setup(){
 Scanner keyboard = new Scanner(System.in);
 String paragraph = keyboard.next();
 int r = 245;
 int g = 219;
 int b = 255;
 
 String temp;
 Node prevNode;
 Node newNode;
 int spaceIndex;
 
 while(paragraph.length()>0){
   
   spaceIndex = paragraph.indexOf(" ");
   
   temp = paragraph.substring(0, spaceIndex);
   if(temp.length()>0)
   {
     if (search(temp)==-1)
     {
       newNode = new Node(temp, r, g, b, 0);
       inputs.add(newNode);
     }
     else
     {
       prevNode = inputs.get(search(temp));
       newNode = new Node(temp, prevNode.r, prevNode.g, prevNode.b, prevNode.getFreq());
       inputs.add(newNode);
     }
   }
   paragraph = paragraph.substring(spaceIndex+1);
 }
 
 keyboard.close();
}
