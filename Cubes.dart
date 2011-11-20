#import('dart:dom');

class Cubes {
  
  CanvasRenderingContext2D ctx;
  var hfov = 100 * Math.PI / 180;
  var vfov = 80 * Math.PI / 180;
  List<Point> vertices;

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
    
    
    
  }
  
  drawCube(List<Point> vertices){
    var hViewDistance = ( 300 / 2 ) / Math.tan( hfov / 2 );
    var vViewDistance = ( 300 / 2 ) / Math.tan( vfov / 2 );
    
    
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
}

main(){
  new Cubes();
}


