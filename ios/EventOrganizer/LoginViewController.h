//
//  LoginViewController.h
//  EventOrganizer
//
//  Created by Deema Abdallah
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)LoginUser:(id)sender;

@end
