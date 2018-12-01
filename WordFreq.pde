class Node{
   String input;
   int freq;
   int r, g, b;
   
   public Node(String inputin, int rin, int gin, int bin){
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

ArrayList<Inputs> inputs = new ArrayList<Inputs>();
