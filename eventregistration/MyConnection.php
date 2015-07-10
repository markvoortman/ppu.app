<?php
class MyConnection {

   private $conn = null;
   private $host ="bus1.pointpark.edu";
   private $user = "fmali";
   private $psw = "cmps322";
   private $db = "fmali";
   private $schema = "pointevent";
   private $name = "Default";
   private $query = null;
   private $result = null;
   private $sucess = null;
   
   function __construct() {
       //print "In constructor\n";
       $this->name = "Connection values for a Database";
   }
   function __destruct()
   {
       //echo("Destroying object<br>");
       if( $this->isConnected() == true)
       {
           //echo ("Closing connection");
           pg_close($this->conn);
       }
   }
   function setConn()
   {
    $this->conn = pg_connect("host= $this->host dbname= $this->db user= $this->user password=$this->psw")
     or die('Could not connect: ' . pg_last_error());
     
   }
   function getConn()
   {
     return $this->conn;
    }
    function closeConn()
    {
      pg_close($this->getConn());
       $this->conn = null;

    }
    function isConnected()
    {
       if(  $this->getConn() == null )
       {
         return (false);
        }
        return (true); 
    }
    
   function getHost()
   {
     return $this->host;
   }
   function setHost($h)
   {
     $this->host = $h;
    }
     
   function getUser()
   {
     return  $this->user;
    }
   function setUser($u)
   {
     $this->user = $u;
   }
   function getPsw()
   {
     return  $this->psw;
   }
   function setPsw($p)
   {
      $this->psw = $p;
    }
   function getDb()
   {
     return  $this->db;
    }
   function setDb($d)
   {
      $this->db = $d;
   }
   function getSchema()
   {
     return  $this->schema;
   }
   function setSchema($s)
   {
      $this->schema = $s;
    }
   function displayValues()
   {
     echo "Current Values of Connection Object\n<br>";
     echo ("Host: ".$this->getHost()."\n<br>");
     echo ("User: ".$this->getUser()."\n<br>");  
     echo ("Password: ".$this->getPsw()."\n<br>");   
     echo ("Database: ".$this->getDb()."\n<br>");  
     echo ("Schema: ".$this->getSchema()."\n<br>"); 
     echo ("Connected: ".$this->isConnected()."\n<br>");
     if ( $this->isConnected() == false )
     {
        echo( "false<br>");
     }
     if ( $this->isConnected() == true)
     {
        echo ( "true<br>");
     }
   } 
      function executeQuery($q)
   {
     $this->setQuery($q);
     $this->setResult(pg_query($q));
     if($this->getResult() == null)
     {
       die($q." query failed.");
     }

   }
 function setQuery( $q)
   {
      $this->query = $q;
   }
   function getQuery()
   {
      return $this->query;
   }
   
   function setResult($r)
   {
     $this->result = $r;
   }
   function getResult()
   {
     return $this->result;
   }
   function freeResult()
   {
      if( $this->getResult() != null)
      {
         pg_free_result($this->getResult());
      }
   
   }
   function getFields()
   {
          $nFields = pg_num_fields($this->getResult());
          $i =0;
          while( $i < $nFields)
          {   
            $b[$i] = pg_field_name($this->getResult(), $i);
            $i= $i +1;
          }
          return $b;
   }
   function getRow()
   {
       return pg_fetch_array($this->getResult(), null, PGSQL_ASSOC);
   
   }
     function displayTable( )
   {  
   //displays the results of a query as a HTML table
     if ( $this->getQuery() == null)
       {
          die('Query not set for display table');
        }
            
     $this->setResult( pg_query( $this->getQuery()));    
     if ( $this->getResult() == null)
       {
          die('Query failed in display table:' . pg_lasterror());
        }
        
     echo("<table>\n");
     echo("<tr>\n");
//process headings
     $fieldNames = $this->getFields();
     foreach ($fieldNames as $name)  
     {
         echo("<td align=\"center\" >$name</td>\n");        
     }
    echo("</tr>\n");
// Printing results in HTML
   while ($line = $this->getRow()) 
   {
      echo ("\t<tr>\n");
      foreach ($line as $col_value) 
        {
          echo ("\t\t<td >$col_value</td>\n");
        }
      echo ("\t</tr>\n");
    }
 
   echo("</table>");
  }    
  }



?>
