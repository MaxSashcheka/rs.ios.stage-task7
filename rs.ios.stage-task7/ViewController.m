//
//  ViewController.m
//  rs.ios.stage-task7
//
//  Created by Max Sashcheka on 7/5/21.
//

#import "ViewController.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                 blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                alpha:1.0]

//NSString* userName = @"abc";
//NSString* password = @"abc";
//NSString* currentPassword = @"";

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic,strong) NSString* correctUserName;
@property (nonatomic,strong) NSString* correctPassword;
@property (nonatomic,strong) NSString* correctDecimals;
@property (nonatomic,strong) NSString* currentPassword;

@property (nonatomic,strong) UILabel* rsschoolNameLabel;

@property (nonatomic,strong) UITextField* userNameTextField;
@property (nonatomic,strong) UITextField* passwordTextField;

@property (nonatomic,strong) UILabel* authorizeLabel;
@property (nonatomic,strong) UIButton* authorizeButton;

@property (nonatomic,strong) UIView* addView;
@property (nonatomic,strong) UILabel* decimalsLabel;

@property (nonatomic,strong) UIButton* oneButton;
@property (nonatomic,strong) UIButton* twoButton;
@property (nonatomic,strong) UIButton* threeButton;

@property (nonatomic,strong) UILabel *oneLabel;
@property (nonatomic,strong) UILabel *twoLabel;
@property (nonatomic,strong) UILabel *threeLabel;

@property (nonatomic) NSInteger counter;


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _correctUserName = @"username";
    _correctPassword = @"password";
    _correctDecimals = @"132";
    _counter = 0;
    _currentPassword = @"";
    
//    [_userNameTextField setDelegate:self];
//    [_passwordTextField setDelegate:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    _rsschoolNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 80, self.view.frame.size.width, 40)];
    _rsschoolNameLabel.textAlignment = NSTextAlignmentCenter;
    _rsschoolNameLabel.font = [UIFont boldSystemFontOfSize:36];
    _rsschoolNameLabel.text = @"RSSchool";
    _rsschoolNameLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_rsschoolNameLabel];


    _userNameTextField = [[UITextField alloc] initWithFrame: CGRectMake(36, 200, 303, 40)];
    _userNameTextField.placeholder = @"Login";
    _userNameTextField.layer.borderColor = [UIColorFromRGB(0x4C5C68) CGColor];
    _userNameTextField.layer.borderWidth = 1.5;
    _userNameTextField.layer.cornerRadius = 5;
    
    _userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_userNameTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame: CGRectMake(36, 270, 303, 40)];
    _passwordTextField.placeholder = @"Password";
    _passwordTextField.layer.borderColor = [UIColorFromRGB(0x4C5C68) CGColor];
    _passwordTextField.layer.borderWidth = 1.5;
    _passwordTextField.layer.cornerRadius = 5;
    
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    [_passwordTextField addTarget:self
                  action:@selector(passwordTextFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:_passwordTextField];
    
    _authorizeButton = [[UIButton alloc] initWithFrame: CGRectMake(109.5, 370, 156, 42)];// 109.5, 370, 156, 42
    _authorizeButton.layer.cornerRadius = 10;
    _authorizeButton.layer.borderWidth = 2;
    _authorizeButton.layer.borderColor = [UIColorFromRGB(0x80A4ED) CGColor];
    
    [_authorizeButton setTitle:@"Authorize" forState:UIControlStateNormal];
    _authorizeButton.titleLabel.font = [UIFont systemFontOfSize:20];

    [_authorizeButton addTarget:self
                         action:@selector(authorizeButtonTapped:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [_authorizeButton setImage:[UIImage systemImageNamed:@"person"] forState: normal];
    [self.view addSubview:_authorizeButton];
    
    
    _authorizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 374, 120, 35)];
    _authorizeLabel.font = [UIFont boldSystemFontOfSize:21];
    _authorizeLabel.text = @"Authrorize";
    _authorizeLabel.textColor = UIColorFromRGB(0x80A4ED);
    
    [self.view addSubview:_authorizeLabel];
    
    
    //==========================================================================================================================//
    
    _addView = [[UIView alloc] initWithFrame:CGRectMake(70, 490, 235, 120)];
    _addView.layer.cornerRadius = 10;
    _addView.layer.borderWidth = 2;
    _addView.layer.borderColor = [UIColorFromRGB(0xC20114) CGColor];
    
    [self.view addSubview:_addView];
    
    _oneButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 540, 55, 55)];
    _oneButton.layer.cornerRadius = _oneButton.frame.size.height / 2;
    _oneButton.layer.borderWidth = 2;
    _oneButton.layer.borderColor = [UIColorFromRGB(0x80A4ED) CGColor];
    
//    [_oneButton setTitle:@"1" forState:UIControlStateNormal]
    [self.view addSubview:_oneButton];
    
    _oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(109, 540, 55, 55)];
    _oneLabel.font = [UIFont systemFontOfSize:33];
    _oneLabel.textColor = UIColorFromRGB(0x80A4ED);
    _oneLabel.text = @"1";
    
    [self.view addSubview:_oneLabel];
    
    _twoButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 540, 55, 55)];
    _twoButton.layer.cornerRadius = _twoButton.frame.size.height / 2;
    _twoButton.layer.borderWidth = 2;
    _twoButton.layer.borderColor = [UIColorFromRGB(0x80A4ED) CGColor];
    
    [self.view addSubview:_twoButton];
    
    _twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(179, 540, 55, 55)];
    _twoLabel.font = [UIFont systemFontOfSize:33];
    _twoLabel.textColor = UIColorFromRGB(0x80A4ED);
    _twoLabel.text = @"2";
    
    [self.view addSubview:_twoLabel];
    
    _threeButton = [[UIButton alloc] initWithFrame:CGRectMake(230, 540, 55, 55)];
    _threeButton.layer.cornerRadius = _threeButton.frame.size.height / 2;
    _threeButton.layer.borderWidth = 2;
    _threeButton.layer.borderColor = [UIColorFromRGB(0x80A4ED) CGColor];
    
    [self.view addSubview:_threeButton];
    
    _threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(249, 540, 55, 55)];
    _threeLabel.font = [UIFont systemFontOfSize:33];
    _threeLabel.textColor = UIColorFromRGB(0x80A4ED);
    _threeLabel.text = @"3";
    
    [self.view addSubview:_threeLabel];
    
    _decimalsLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 500, 235, 30)];
    _decimalsLabel.textAlignment = NSTextAlignmentCenter;
    _decimalsLabel.font = [UIFont boldSystemFontOfSize:22];
    _decimalsLabel.text = @"_";
    
    [self.view addSubview:_decimalsLabel];
   
    [_oneButton addTarget:self
                   action:@selector(oneButtonTapped:)
         forControlEvents:UIControlEventTouchUpInside];
    [_twoButton addTarget:self
                   action:@selector(twoButtonTapped:)
         forControlEvents:UIControlEventTouchUpInside];
    [_threeButton addTarget:self
                   action:@selector(threeButtonTapped:)
         forControlEvents:UIControlEventTouchUpInside];
    
    _addView.hidden = YES;
    _oneButton.hidden = YES;
    _twoButton.hidden = YES;
    _threeButton.hidden = YES;
    _oneLabel.hidden = YES;
    _twoLabel.hidden = YES;
    _threeLabel.hidden = YES;
    _decimalsLabel.hidden = YES;
    
}

//MARK: - Methods

- (void) passwordTextFieldDidChange:(UITextField *) textField {
 
    if (textField.text.length == _currentPassword.length - 1) {
        _currentPassword = [_currentPassword substringToIndex:[_currentPassword length] - 1];
    } else {
        NSRange rangeOfLastChar = NSMakeRange(textField.text.length - 1, 1);
        _currentPassword = [_currentPassword stringByAppendingString: [textField.text substringWithRange:rangeOfLastChar] ];
    }
    NSString* securityPassword = @"";
    
    for (int i = 0; i < textField.text.length; i++) {
        securityPassword = [securityPassword stringByAppendingString:@"*"];
    }
    textField.text = securityPassword;

    NSLog(@"Current password = %@", _currentPassword);
}

- (void) authorizeButtonTapped:(UIButton *) button {
    BOOL isUserNameCorrect = [_userNameTextField.text isEqualToString:_correctUserName];
    BOOL isPasswordCorrect = [_currentPassword isEqualToString:_correctPassword];

    
    if (isUserNameCorrect && isPasswordCorrect) { // все верно
        _userNameTextField.layer.borderColor = [UIColorFromRGB(0x91C7B1) CGColor];
        _passwordTextField.layer.borderColor = [UIColorFromRGB(0x91C7B1) CGColor];
        
        _userNameTextField.layer.opacity = 0.5;
        _passwordTextField.layer.opacity = 0.5;
        button.layer.opacity = 0.5;
        _authorizeLabel.layer.opacity = 0.5;
        
        _userNameTextField.enabled = NO;
        _passwordTextField.enabled = NO;
        button.enabled = NO;
        
        
        _oneButton.hidden = NO;
        _twoButton.hidden = NO;
        _threeButton.hidden = NO;
        _oneLabel.hidden = NO;
        _twoLabel.hidden = NO;
        _threeLabel.hidden = NO;
        _decimalsLabel.hidden = NO;
        
    } else if (isUserNameCorrect && !isPasswordCorrect) { //логин верный
        _userNameTextField.layer.borderColor = [UIColorFromRGB(0x91C7B1) CGColor];
        _passwordTextField.layer.borderColor = [UIColorFromRGB(0xC20114) CGColor];
    } else if (!isUserNameCorrect && isPasswordCorrect) { //пароль верный
        _userNameTextField.layer.borderColor = [UIColorFromRGB(0xC20114) CGColor];
        _passwordTextField.layer.borderColor = [UIColorFromRGB(0x91C7B1) CGColor];
    } else { // ничего не верно
        _userNameTextField.layer.borderColor = [UIColorFromRGB(0xC20114) CGColor];
        _passwordTextField.layer.borderColor = [UIColorFromRGB(0xC20114) CGColor];
    }
    
}

-(void)dismissKeyboard {
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (void) oneButtonTapped: (UIButton*) button {
    if ([_decimalsLabel.text isEqualToString:@"_"]) {
        _addView.layer.borderColor = [[UIColor whiteColor] CGColor];
        _decimalsLabel.text = @"1";
        return;
    }
    
    _decimalsLabel.text = [_decimalsLabel.text stringByAppendingString:@"1"];
    
    if (_decimalsLabel.text.length == 3) {
        _addView.hidden = NO;
        if ([_decimalsLabel.text isEqualToString:_correctDecimals]) {
            _addView.layer.borderColor = [UIColorFromRGB(0x91C7B1) CGColor];
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Welcome"
                                           message:@"You are successfuly authorized!"
                                           preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDestructive
               handler:^(UIAlertAction * action) {}];
             
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
             
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            _addView.layer.borderColor = [UIColorFromRGB(0xC20114) CGColor];
            _decimalsLabel.text = @"_";

        }
        _counter++;
        
    }
}

- (void) twoButtonTapped: (UIButton*) button {
    if ([_decimalsLabel.text isEqualToString:@"_"]) {
        _addView.layer.borderColor = [[UIColor whiteColor] CGColor];
        _decimalsLabel.text = @"2";
        return;
    }
    _decimalsLabel.text = [_decimalsLabel.text stringByAppendingString:@"2"];

    if (_decimalsLabel.text.length == 3) {
        _addView.hidden = NO;
        if ([_decimalsLabel.text isEqualToString:_correctDecimals]) {
            _addView.layer.borderColor = [UIColorFromRGB(0x91C7B1) CGColor];
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Welcome"
                                           message:@"You are successfuly authorized!"
                                           preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDestructive
               handler:^(UIAlertAction * action) {}];
             
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            _addView.layer.borderColor = [UIColorFromRGB(0xC20114) CGColor];
            _decimalsLabel.text = @"_";
        }
        _counter++;
    }
}

- (void) threeButtonTapped: (UIButton*) button {
    if ([_decimalsLabel.text isEqualToString:@"_"]) {
        _decimalsLabel.text = @"3";
        _addView.layer.borderColor = [[UIColor whiteColor] CGColor];

        return;
    }
    _decimalsLabel.text = [_decimalsLabel.text stringByAppendingString:@"3"];

    if (_decimalsLabel.text.length == 3) {
        _addView.hidden = NO;
        if ([_decimalsLabel.text isEqualToString:_correctDecimals]) {
            _addView.layer.borderColor = [UIColorFromRGB(0x91C7B1) CGColor];
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Welcome"
                                           message:@"You are successfuly authorized!"
                                           preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDestructive
               handler:^(UIAlertAction * action) {}];
             
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        } else {
            _addView.layer.borderColor = [UIColorFromRGB(0xC20114) CGColor];
            _decimalsLabel.text = @"_";

        }
        _counter++;
    }
}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}

@end

//Height = 667
//Width = 375


// white 0xFFFFFF
// Black Coral 0x4C5C68
// Turquoise Green 0x91C7B1
// Venetian Red 0xC20114
// Black 0x000000
// Little Boy Blue 0x80A4ED

