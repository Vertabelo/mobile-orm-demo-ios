#import "AddPlaceViewController.h"
#import "DemoSQLiteOpenHelper.h"
#import "EditTagsCollectionViewCell.h"
#import "AppDelegate.h"

@interface AddPlaceViewController ()

@property PlaceManager *placeManager;
@property AddressManager *addressManager;
@property TagManager *tagManager;
@property UIAlertView *tagNameAlert;

-(void)prepareForSave;
-(void)prepareForConfirmEdit;
-(void)prepareForSaveNewPlace;

@end

@implementation AddPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.comment layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.comment layer] setBorderWidth:0.4];
    
    [self.image.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.image.layer setBorderWidth:0.4];
    
    self.placeManager = [AppDelegate placeManager];
    self.addressManager = [AppDelegate addressManager];
    self.tagManager = [AppDelegate tagManager];
    
    if (self.placeToEdit) {
        AddressView *addressView = [self.addressManager addressViewForPlace:self.placeToEdit];
        
        self.placeName.text = self.placeToEdit.columnName;
        self.rating.selectedSegmentIndex = [self.placeToEdit.columnRating intValue] - 1;
        self.address.text = addressView.columnAddress;
        self.city.text = addressView.columnCityName;
        self.country.text = addressView.columnCountryName;
        self.comment.text = self.placeToEdit.columnComment;
        
        NSData *data = [self.placeManager imageForPlace:self.placeToEdit];
        if (![data isKindOfClass: [NSNull class]]) {
            self.image.image = [UIImage imageWithData:data];
        }
        
        NSArray *tags = [self.tagManager tagsForPlace:self.placeToEdit];
        NSMutableArray *tagsNames = [[NSMutableArray alloc] init];
        for (Tag *tag in tags) {
            [tagsNames addObject:tag.columnName];
        }
        self.tagsView.tags = [[NSMutableArray alloc] initWithArray:tagsNames];
    } else {
        self.tagsView.tags = [[NSMutableArray alloc] init];
    }
    
    self.tagNameAlert = [[UIAlertView alloc] initWithTitle:@"New tag" message:@"Enter new tag's name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    self.tagNameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    self.tagsView.delegate = self;
    self.tagsView.dataSource = self;
    [self.tagsView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (sender == self.save) {
        if ((self.placeName.text.length == 0 || self.country.text.length == 0 ||
             self.city.text.length == 0 || self.rating.selectedSegmentIndex == UISegmentedControlNoSegment)) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please complete all the fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender == self.save) {
        [self prepareForSave];
    }
}

-(void)prepareForSave {
    if (!self.placeToEdit) {
        [self prepareForSaveNewPlace];
    } else {
        [self prepareForConfirmEdit];
    }
}

-(void)prepareForSaveNewPlace {
    NSNumber *addressId = [self.addressManager insertAddress:self.address.text city:self.city.text country:self.country.text];
    
    Place *place = [Place place];
    place.columnName = self.placeName.text;
    place.columnRating = @(self.rating.selectedSegmentIndex + 1);
    place.columnAdded = [NSDate date];
    if (self.comment.text.length > 0) {
        place.columnComment = self.comment.text;
    }
    place.columnAddressId = addressId;
    
    [self.placeManager insertPlace:place];
   
    [self.tagManager insertOrUpdateTags:self.tagsView.tags forPlace:place];
    
    if (self.image.image) {
        NSData *imageData = UIImagePNGRepresentation(self.image.image);
        [self.placeManager insertImage:imageData forPlace:place];
    }
}

-(void)prepareForConfirmEdit {
    NSNumber* addressId = [self.addressManager insertAddress:self.address.text city:self.city.text country:self.country.text];
    
    self.placeToEdit.columnName = self.placeName.text;
    self.placeToEdit.columnRating = @(self.rating.selectedSegmentIndex + 1);
    self.placeToEdit.columnComment = self.comment.text;
    self.placeToEdit.columnAddressId = addressId;
    
    [self.placeManager updatePlace:self.placeToEdit];
    
    [self.tagManager insertOrUpdateTags:self.tagsView.tags forPlace:self.placeToEdit];
    
    if (self.image.image) {
        NSData *imageData = UIImagePNGRepresentation(self.image.image);
        [self.placeManager insertImage:imageData forPlace:self.placeToEdit];
    }
}

- (IBAction)gallery:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.image.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)addTag:(UIButton *)sender {
    [self.tagNameAlert show];
    [self.tagNameAlert textFieldAtIndex:0].text = @"";
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"New tag"]) {
        if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Save"]) {
            [self.tagsView.tags addObject:[alertView textFieldAtIndex:0].text];
            [self.tagsView reloadData];
        }
    }
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.tagsView.tags count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EditTagsCollectionViewCell *cell = [self.tagsView dequeueReusableCellWithReuseIdentifier:@"editTagCell" forIndexPath:indexPath];
    cell.tagName.text = [self.tagsView.tags objectAtIndex:[indexPath row]];
    return cell;
}

@end
