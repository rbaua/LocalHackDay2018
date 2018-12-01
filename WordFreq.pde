import java.util.*;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.io.File;

//bless this mess
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
     if (r > 187){
       r = r - 1;
     }
     if (g > 0){
       g = g - 3;
     }
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
 size(1000, 1000);
 parseInput();
}

void parseInput(){
 File file = new File("UserInput.txt");
 try{
 Scanner sc = new Scanner(file);
 String paragraph = sc.next();
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
 
 sc.close();
 }
 catch (FileNotFoundException e) {
  System.out.println("File not found");
 }
}

void draw(){
  drawText(); 
}

void drawText(){
  int x= 10;
  int y=10;
  
  
  
  for(int i=0; i<inputs.size(); i++){
     fill(inputs.get(i).r, inputs.get(i).g, inputs.get(i).b);
     text(inputs.get(i).getWord(), x, y);
     y+=15;
  }
}
