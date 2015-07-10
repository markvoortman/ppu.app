<?php
class MyCode {

   private $conn = null;  
   private $name = "Default";
   private $query = null;
   private $schema = null;
   private $result = null;
   private $sucess = null;
   
   function __construct() {
       //print "In constructor\n";
       $this->name = "Private Operations on Database";
   }
   function __destruct()
   {
       //echo("Destroying object<br>");
       if( $this->isConnected() == true)
       {
           //echo ("Closing connection");
           $this->conn = null;
       }
   }
//   
   function setConn($c)
   {
    $this->conn = $c;
     
   }
//   
   function getConn()
   {
     return $this->conn;
   }
//   
    function closeConn()
    {
       $this->conn = null;
    }
//    
    function isConnected()
    {
       if(  $this->getConn() == null )
       {
         return (false);
       }
        return (true); 
    }
//       
   function getSchema()
   {
     return  $this->schema;
   }
//
   function setSchema($s)
   {
      $this->schema = $s;
    }
//
   function executeQuery($q)
   {
     $this->setQuery($q);
     $this->setResult(pg_query($q));
     if($this->getResult() == null)
     {
       die($q." query failed.");
     }

   }
//
   function setQuery( $q)
   {
      $this->query = $q;
   }
//
   function getQuery()
   {
      return $this->query;
   }
//   
   function setResult($r)
   {
     $this->result = $r;
   }
//
   function getResult()
   {
     return $this->result;
   }
//
   function freeResult()
   {
      if( $this->getResult() != null)
      {
         pg_free_result($this->getResult());
      }
   
   }
//
      function displaySelection($id, $f)
   {
   //
   // $id is the name of the seletion box in the select tag
   // $f  is the field name for use in fetching the value to 
   //     place in the selection.  It is the field name to index the result of the 
   //     query. 
   //set the query then use this method
   //The result returned is a string $s
   // as the formatted HTML selection object with id as $id
   // NOTE: Query should be set before calling this method.
   // Usage: echo(displaySelection("partsList", "partId") )
   //
     if ( $this->getQuery() == null)
       {
          die('Query not set for display selection');
        }  
    $this->setResult( pg_query( $this->getQuery()));    
     if ( $this->getResult() == null)
       {
          die('Query failed while forming selection:' . pg_lasterror());
       }
     $s =   "<SELECT name='$id'>\n";
     while ($line = $this->getRow()) 
     {
       $s = $s."\t<option value=\"".$line[$f]."\">".$line[$f]."\n";
     } 
     $s = $s. "</SELECT>";
     return $s;     
   }
//
   function getFields()
   {
   //returns a list of field names meta data
   //
          $nFields = pg_num_fields($this->getResult());
          $i =0;
          while( $i < $nFields)
          {   
            $b[$i] = pg_field_name($this->getResult(), $i);
            $i= $i +1;
          }
          return $b;
   }
//
   function getRow()
   {
   // returns 1 row in a result set.
   //
       return pg_fetch_array($this->getResult(), null, PGSQL_ASSOC);
   
   }
   function doUpdate()
{
   if( $this->getQuery() == null)
   {  echo('Query not set!'); die('Query not set!');}
   $this->setResult(pg_query($this->getQuery()));
   if($this->getResult() == null)
   { echo('Update failed!');}
   else 
   { echo('Update success!');}
}
//
     function displayTable( )
   { 
   //  
   //displays the results of a query as a HTML table
   //you should set the query before call this method.
   //
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
  
 function jsonFun()
 {
	//  
   //displays the results of a query as a JSON array of objects 
   //you should set the query before calling this method.
   //
     if ( $this->getQuery() == null)
       {
          die('Query not set for display table');
        }
            
     $this->setResult( pg_query( $this->getQuery()));    
     if ( $this->getResult() == null)
       {
          die('Query failed in display table:' . pg_lasterror());
        }
        
//process result
     return( json_encode($this->getRow()) );
 
	 
 }
 
function jsonTable( )
   { 
   //  
   //displays the results of a query as a JSON array of objects 
   //you should set the query before calling this method.
   //
     if ( $this->getQuery() == null)
       {
          die('Query not set for display table');
        }
            
     $this->setResult( pg_query( $this->getQuery()));    
     if ( $this->getResult() == null)
       {
          die('Query failed in display table:' . pg_lasterror());
        }
        
//process headings
     $rows = pg_num_rows($this->getResult());
	  echo("[");
	  while ($line = $this->getRow()) 
     {
       
       echo( json_encode($line) );
	   
	   if( --$rows > 0)
	   {
		   echo(" , \n");
	   }
	 }
	 echo("]");
  }     
     
 
 
 
  }



?>
