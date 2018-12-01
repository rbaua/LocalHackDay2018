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
     clipPunct(inputin);
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
int windowWidth = 1000;
int windowHeight = 1000;
boolean page1 = true;
boolean page2 = false;
ArrayList<Node> summary;


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

 String[] lines = loadStrings("UserInput.txt");
 
 int r = 245;
 int g = 219;
 int b = 255;
 
 String temp;
 Node prevNode;
 Node newNode;
 int spaceIndex;
 
 for( int i=0; i < lines.length; i++){ 
   if(!lines[i].equals("")){
     lines[i] = lines[i].substring(0, lines[i].length()-1);
   }
  
   while(lines[i] != "" && lines[i] != "\n" && lines[i] != " "){
   
     spaceIndex = lines[i].indexOf(" ");   
   
     if (spaceIndex == -1){
        
       newNode = new Node(lines[i], r, g, b, 0);
       inputs.add(newNode);
       
       lines[i] = "";
       
     } else {
       temp = lines[i].substring(0, spaceIndex);
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
       lines[i] = lines[i].substring(spaceIndex+1);
     }
     }
 }
 summary = summary(inputs);
}


void draw(){
  background(53, 56, 57);
  if(page1==true){
     drawText(); 
  }
  else{
     drawResults(); 
  }
}

void mousePressed(){
  if(mousePressed && mouseButton == LEFT)
  {
      page1=false;
      page2=true;
  }
  else if(mousePressed && mouseButton == RIGHT)
  {
      page1=true;
      page2=false;
  }
}

void drawText(){
  int x= 10;
  int y=20;
  int wordSize;
  
  PFont font = loadFont("CambriaMath.vlw");
  textFont(font);
  textSize(20);
  for(int i=0; i<inputs.size(); i++){
    wordSize = int(textWidth(inputs.get(i).getWord()) + textWidth(" "));
    if(x>windowWidth-wordSize)
     {
       x=10;
       y+=25;
     }
     fill(inputs.get(i).r, inputs.get(i).g, inputs.get(i).b);
     text(inputs.get(i).getWord(), x, y);
     
     x+= wordSize;
     
  }
}

void clipPunct(String s){
 int period = s.indexOf(".");
 int comma = s.indexOf(",");
 int quote = s.indexOf("\"");
 int exclamation = s.indexOf("!");
 int question = s.indexOf("?");
 if(period ==0 || comma==0 || quote ==0 || exclamation ==0 || question == 0){
  s=s.substring(1); 
 }
 else if (period == s.length() || comma==s.length() || quote ==s.length() || exclamation ==s.length() || question == s.length()){
  s=s.substring(0, s.length()-1);
 }
}



void drawResults()
{
  int x= 50;
  int y=20;
  int wordSize;
  
  PFont font = loadFont("CambriaMath.vlw");
  textFont(font);
  textSize(20);
  
  for(int i=0; i<summary.size(); i++){
     wordSize = int(textWidth(summary.get(i).getWord()) + textWidth(" "));
    
     fill(inputs.get(i).r, inputs.get(i).g, inputs.get(i).b);
     text(inputs.get(i).getWord(), x, y);
     
     x+= wordSize;
     
     text(" = ", x, y);
     
     x+=textWidth(" =  ");
     
     text(summary.get(i).getFreq(), x, y);
     
     y+=25;
     x=50;
     
  }
}

ArrayList<Node> summary(ArrayList<Node> A){
    ArrayList<Node> summary = new ArrayList<Node>();
    ArrayList<Node> temp = new ArrayList<Node>();
    for(Node n : A) {
      temp.add(n);
    }
    String thing = "";
    int max = 0;
    int index = -1;
    
    for( int j=0; j < 15; j++){
      for( Node object1: temp){
        if (object1.freq > max){
          max = object1.freq;
          index = temp.indexOf(object1);
          thing = object1.input;
        }
      }
      
      Node add = temp.get(index);
      summary.add(add);
   
      for( Node object2: temp){
        if (object2.input.equals(thing)){
          int target = temp.indexOf(object2);
          temp.remove(target);
        }
      }
    }
    
    return summary;
}
