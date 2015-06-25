//
//  LoginViewController.m
//  EventOrganizer
//
//  Created by Deema Abdallah
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController {

    NSMutableData *mutableData;
    NSInteger authSuccess;

    #define URL            @"http://host22.cmps.pointpark.edu/test.php"  // change this URL
    #define NO_CONNECTION  @"No Connection"
    #define NO_VALUES      @"Please enter parameter values"

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}



- (void)viewDidAppear:(BOOL)animated {
    
    [self.logoImageView setImage:[UIImage imageNamed:@"PPULogo"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)LoginUser:(id)sender {
    
    [self sendDataToServer :@"POST"];
}

-(void) sendDataToServer : (NSString *) method{
    
    if(self.emailField.text.length > 0 && self.passwordField.text.length > 0){
        
    
        NSString *parameter = [NSString stringWithFormat:@"username=%@&password=%@",self.emailField.text, self.passwordField.text];
        
        NSLog(@"PostData: %@",parameter);
        NSURL *url=[NSURL URLWithString:URL];
        NSData *postData = [parameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request addValue: @"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
        
        if(connection)
        {
            mutableData = [NSMutableData new];
    
        }else{
            UIAlertView * noValuesAlert = [[UIAlertView alloc]initWithTitle:@"Failure" message:@"Please try again! Server Failure" delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil];
            [noValuesAlert show];
            NSLog(@"No connection");
    
        }

    }else{
    
        NSLog(@"Username and password are required!");
        UIAlertView * noValuesAlert = [[UIAlertView alloc]initWithTitle:@"Failure" message:@"Please enter a valid username and password!" delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil];
        [noValuesAlert show];
        NSLog(@"No values");
    }




  /*  if(self.emailField.text.length > 0 && self.passwordField.text.length > 0){
        NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@",[self.emailField text],[self.passwordField text]];
        NSLog(@"PostData: %@",post);
        NSURL *url=[NSURL URLWithString:URL];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSLog(@"Response code: %d", [response statusCode]);
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"ResponseData ==> %@", responseData);
            //I also need to save the token here for future login
            //This is where I think we should prepare for the second view
            [self performSegueWithIdentifier:@"Login" sender:self];

        } else {
            
            NSLog(@"Username and password are invalid!");
            UIAlertView * noValuesAlert = [[UIAlertView alloc]initWithTitle:@"Failure" message:@"The email or password entered is incorrect!" delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil];
            [noValuesAlert show];
            NSLog(@"No values");
            //[self alertStatus:@"Please enter both Username and Password" :@"Login Failed!"];
        }
        
    } else {
        NSLog(@"Username and password are required!");
        UIAlertView * noValuesAlert = [[UIAlertView alloc]initWithTitle:@"Failure" message:@"Please enter a valid username and password!" delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil];
        [noValuesAlert show];
        NSLog(@"No values");
    } */
    
}

#pragma mark NSURLConnection delegates

/*- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    NSString *username  = self.emailField.text;
    NSString *password = self.passwordField.text;

    
    NSLog(@"%@", challenge.protectionSpace);
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPDigest])
    {
        if ([challenge previousFailureCount] == 0)
        {
            [[challenge sender] useCredential:[NSURLCredential credentialWithUser:username
                                                                         password:password
                                                                      persistence:NSURLCredentialPersistenceNone]
                   forAuthenticationChallenge:challenge];
        }
        else
        {
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        }
    }
    else
    {
        [[challenge sender] rejectProtectionSpaceAndContinueWithChallenge:challenge];
    }
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection {
    return YES;
}*/

/*-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    //return YES to say that we have the necessary credentials to access the requested resource
    return YES;
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
    NSString *username  = self.emailField.text;
    NSString *password = self.passwordField.text;
    
    NSURLCredential *credential = [NSURLCredential credentialWithUser:username
                                                             password:password
                                persistence:NSURLCredentialPersistenceForSession];
    
    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}*/


-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    NSUInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
    NSLog(@"Response code is: %d", statusCode);
    if (statusCode >=200 && statusCode <300)
    {
        //NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        //NSLog(@"ResponseData ==> %@", responseData);
        //I also need to save the token here for future login
        //This is where I think we should prepare for the second view
        authSuccess = 1;
        NSLog(@"Success, Response is %@", response);
        [mutableData setLength:0];
        [self performSegueWithIdentifier:@"Login" sender:self];
        
    }
    else {
        
        authSuccess = 0;
        NSLog(@"Username and password are invalid!");
        UIAlertView * noValuesAlert = [[UIAlertView alloc]initWithTitle:@"Failure" message:@"The email or password entered is incorrect!" delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil];
        [noValuesAlert show];
        //NSLog(@"Failure, Response is %@", response);
    }
    
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(authSuccess == 1) {
        [mutableData appendData:data];
        NSLog(@"Data appended is: %@", data);
    }
    else return;
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //self.serverResponse.text = NO_CONNECTION;
    UIAlertView * connFailureAlert = [[UIAlertView alloc]initWithTitle:@"Failure" message:@"Connection failed with error!" delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil];
    [connFailureAlert show];
    return;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *responseStringWithEncoded = [[NSString alloc] initWithData: mutableData encoding:NSUTF8StringEncoding];
    NSLog(@"Response from Server : %@", responseStringWithEncoded);
    
   /* if(mutableData!= nil)
    {
        NSArray *jsonArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:mutableData options:0 error:nil];

    }
    
    
    NSError *err = nil;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[responseStringWithEncoded dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    NSDictionary *dictionary = [array objectAtIndex:0];
    NSString *test = [dictionary objectForKey:@"Token"];
    NSLog(@"Test is %@",test); */
    
    //NSArray *Data = [responseStringWithEncoded componentsSeparatedByString:@":"];

    //NSData *data = [responseStringWithEncoded dataUsingEncoding:NSUTF8StringEncoding];
    //id json = [NSJSONSerialization JSONObjectWithData:mutableData options:0 error:nil];
    //NSLog(@"%@",[json objectForKey:@"Token"]);

    
    //NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[responseStringWithEncoded dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    //NSLog(@"Cleared Data is: %@", attrStr);
    //self.serverResponse.attributedText = attrStr;

    
    //This where I need to save everything in terms of username and token
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceName"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    //NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[responseStringWithEncoded dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    //NSLog(@"Cleared Data is: %@", attrStr);
    //self.serverResponse.attributedText = attrStr;
}



@end
