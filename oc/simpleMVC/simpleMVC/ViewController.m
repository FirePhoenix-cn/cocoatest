
#import "ViewController.h"
#import "ViewObj.h"
#import "ModelObj.h"

@interface ViewController ()

@property(strong, nonatomic) ModelObj *modelobj;

@property(strong, nonatomic) ViewObj *sv;

- (IBAction)clickbutton:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sv = [ViewObj loadFromNib];
    [self.sv setFrame:CGRectMake(20.0, 20.0, 300.0, 300.0)];
    [self.view addSubview:self.sv];
    
    self.modelobj = [[ModelObj alloc] init];
    [self.modelobj addObserver:self forKeyPath:@"account" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)clickbutton:(UIButton *)sender
{
    [self.modelobj updateData];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.sv.account.text = [change objectForKey:@"new"];
    self.sv.showdata.text = [change objectForKey:@"old"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.modelobj removeObserver:self forKeyPath:@"account"];
}

@end
