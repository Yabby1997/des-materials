/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Model-view-controller (MVC)
 - - - - - - - - - -
 ![MVC Diagram](MVC_Diagram.png)
 
 The model-view-controller (MVC) pattern separates objects into three types: models, views and controllers.
 
 **Models** hold onto application data. They are usually structs or simple classes.
 
 **Views** display visual elements and controls on screen. They are usually subclasses of `UIView`.
 
 **Controllers** coordinate between models and views. They are usually subclasses of `UIViewController`.
 
 ## Code Example
 */
import UIKit

public struct Address {
    var street: String
    var city: String
    var state: String
    var zipCode: String
}

public final class AddressView: UIView {
    @IBOutlet var streetTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    @IBOutlet var zipCodeTextField: UITextField!
}

/// 모델과 뷰에 대해 강한 참조를 가진다.
/// 모델과 뷰가 함께 조화를 이루도록 하는것이 뷰컨트롤러의 역할
public final class AddressViewController: UIViewController {
    var address: Address? {
        // 모델이 변경되었을 때
        didSet { updateViewFromAddress() }
    }
    
    var addressView: AddressView! {
        guard isViewLoaded else { return nil }
        return (view as! AddressView)
    }
    
    // 뷰가 로드되었을 때
    public override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromAddress()
    }
    
    // 모델의 변화를 뷰에 반영
    private func updateViewFromAddress() {
        guard let address = address else { return }
        addressView.streetTextField.text = address.street
        addressView.cityTextField.text = address.city
        addressView.stateTextField.text = address.state
        addressView.zipCodeTextField.text = address.zipCode
    }
    
    
    // 뷰의 이벤트를 모델에 반영
    @IBAction private func updateAddressFromView(_ sender: AnyObject) {
        guard let street = addressView.streetTextField.text,
              street.count > 0,
              let city = addressView.cityTextField.text,
              city.count > 0,
              let state = addressView.stateTextField.text,
              state.count > 0,
              let zipCode = addressView.zipCodeTextField.text,
              zipCode.count > 0 else { return }
        address = Address(street: street, city: city, state: state, zipCode: zipCode)
    }
}
