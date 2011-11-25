#import('dart:dom');

class Cubes {
  
  CanvasRenderingContext2D ctx;
  var hfov = 100 * Math.PI / 180;
  var vfov = 80 * Math.PI / 180;
  List<Point> vertices;
  
  var Xangle = 0;
  var Yangle = 0;
  var Zangle = 0;

  Cubes() {
    
    var doc = window.document;
    HTMLCanvasElement canvas = doc.getElementById("canvas");
    ctx = canvas.getContext("2d");
    
    
    vertices = new List<Point>(8);
    vertices[0] = new Point(-10,10,20);
    vertices[1]=new Point(10,10,20);
    vertices[2]=new Point(10,10,30);
    vertices[3]=new Point(-10,10,30);
    vertices[4]=new Point(-10,-10,20);
    vertices[5]=new Point(10,-10,20);
    vertices[6]=new Point(10,-10,30);
    vertices[7]=new Point(-10,-10,30);
    
    
    drawCube(vertices);
       
    window.document.onkeydown = (KeyboardEvent e){
      
      
      if(e.keyCode == 37){
        
        
        Xangle = Xangle + 0.005;
        
        
        for(var i = 0; i < vertices.length; i++){
          
//          vertices[i].rotateX(Xangle);
//          vertices[i].rotateY(Yangle);
//          vertices[i].rotateZ(Zangle);
          
            vertices[i] = vertices[i].rotateX(Xangle);
            vertices[i] = vertices[i].rotateY(Yangle);
            vertices[i] = vertices[i].rotateZ(Zangle);
          
        }
        
        drawCube(vertices);
        
      }else if(e.keyCode == 38){
        
         Yangle = Yangle + 0.005;
        
        for(var i = 0; i < vertices.length; i++){
          
          vertices[i] = vertices[i].rotateX(Xangle);
          vertices[i] = vertices[i].rotateY(Yangle);
          vertices[i] = vertices[i].rotateZ(Zangle);
          
        }
        
        drawCube(vertices);
        
      }else if(e.keyCode == 39){
        Xangle = Xangle -  0.005;
        
        
        for(var i = 0; i < vertices.length; i++){
          
          vertices[i] = vertices[i].rotateX(Xangle);
          vertices[i] = vertices[i].rotateY(Yangle);
          vertices[i] = vertices[i].rotateZ(Zangle);
          
        }
        
        
        drawCube(vertices);
        
      }else if(e.keyCode == 40){
        
        Yangle = Yangle + 0.005;
        
        for(var i = 0; i < vertices.length; i++){
          
          vertices[i] = vertices[i].rotateX(Xangle);
          vertices[i] = vertices[i].rotateY(Yangle);
          vertices[i] = vertices[i].rotateZ(Zangle);
          
        }
        
        drawCube(vertices);
      }
      
    };
    
    
    
  }
  
  drawCube(List<Point> vertices){
    var hViewDistance = ( 300 / 2 ) / Math.tan( hfov / 2 );
    var vViewDistance = ( 300 / 2 ) / Math.tan( vfov / 2 );
    
    ctx.clearRect(0,0,300,300);
    
    
    ctx.setFillColor("black");
    ctx.setFillStyle("black");
    ctx.fillRect(0,0,300,300);
    ctx.setStrokeStyle("#444");
    ctx.setLineWidth(2);
    
    ctx.beginPath();
    
    ctx.moveTo(vertices[0].projectedX(hViewDistance), vertices[0].projectedY(vViewDistance));
    ctx.lineTo(vertices[1].projectedX(hViewDistance), vertices[1].projectedY(vViewDistance));
    ctx.lineTo(vertices[2].projectedX(hViewDistance), vertices[2].projectedY(vViewDistance));
    ctx.lineTo(vertices[3].projectedX(hViewDistance), vertices[3].projectedY(vViewDistance));
    ctx.lineTo(vertices[0].projectedX(hViewDistance), vertices[0].projectedY(vViewDistance));

    // Bottom polygon
    ctx.lineTo(vertices[4].projectedX(hViewDistance), vertices[4].projectedY(vViewDistance));
    ctx.lineTo(vertices[5].projectedX(hViewDistance), vertices[5].projectedY(vViewDistance));
    ctx.lineTo(vertices[6].projectedX(hViewDistance), vertices[6].projectedY(vViewDistance));
    ctx.lineTo(vertices[7].projectedX(hViewDistance), vertices[7].projectedY(vViewDistance));
    ctx.lineTo(vertices[4].projectedX(hViewDistance), vertices[4].projectedY(vViewDistance));
    
    // Joining middle lines
    ctx.moveTo(vertices[1].projectedX(hViewDistance), vertices[1].projectedY(vViewDistance));
    ctx.lineTo(vertices[5].projectedX(hViewDistance), vertices[5].projectedY(vViewDistance));
    ctx.moveTo(vertices[2].projectedX(hViewDistance), vertices[2].projectedY(vViewDistance));
    ctx.lineTo(vertices[6].projectedX(hViewDistance), vertices[6].projectedY(vViewDistance));
    ctx.moveTo(vertices[3].projectedX(hViewDistance), vertices[3].projectedY(vViewDistance));
    ctx.lineTo(vertices[7].projectedX(hViewDistance), vertices[7].projectedY(vViewDistance));
    
    ctx.fill();
    ctx.closePath();
    ctx.stroke();
  }

 
}

class Point{
  Point(this.x,this.y,this.z);
   var x,y,z;
   projectedX(hViewDistance) => (this.x * hViewDistance) / this.z  + 300/2 ;
   projectedY(vViewDistance) => (300/2) -  ( this.y * vViewDistance ) / this.z;
   
   rotateX(angle){
     //this.y = this.y * Math.cos(angle*Math.PI/180) - this.z * Math.sin(angle*Math.PI/180);
     //this.z = this.y * Math.sin(angle*Math.PI/180) + this.z + Math.cos(angle*Math.PI/180);
     var newy = this.y * Math.cos(angle) - this.z * Math.sin(angle);
     var newz = this.y * Math.sin(angle) + this.z + Math.cos(angle);
     
     return new Point(this.x, newy, newz);
     
   }
   
   rotateZ(angle){
     //this.x = this.x * Math.cos(angle*Math.PI/180) - this.y * Math.sin(angle*Math.PI/180);
     //this.y = this.x * Math.sin(angle*Math.PI/180) + this.y * Math.cos(angle*Math.PI/180);
     var newx = this.x * Math.cos(angle) - this.y * Math.sin(angle);
     var newy = this.x * Math.sin(angle) + this.y * Math.cos(angle);
     
     return new Point(newx,newy,this.z);
   }
   
   rotateY(angle){
     //this.x = this.x * Math.cos(angle*Math.PI/180) - this.z * Math.sin(angle*Math.PI/180);
     //this.z = this.x * Math.sin(angle*Math.PI/180) + this.z * Math.cos(angle*Math.PI/180);
     var newx = this.x * Math.cos(angle) - this.z * Math.sin(angle);
     var newz = this.x * Math.sin(angle) + this.z * Math.cos(angle);
     
     return new Point(newx,this.y, newz);
   }
}

main(){
  new Cubes();
}
