public enum MediaPickerCropMode {
    case normal
    case custom(CroppingOverlayProvider)
}

public enum MediaPickerContinueButtonStyle {
    case normal
    case spinner
}

public protocol MediaPickerModule: class {

    func focusOnModule()
    func dismissModule()
    
    func finish()
    
    func setContinueButtonTitle(_: String)
    func setContinueButtonEnabled(_: Bool)
    func setContinueButtonVisible(_: Bool)
    func setContinueButtonStyle(_: MediaPickerContinueButtonStyle)
    
    func setAccessDeniedTitle(_: String)
    func setAccessDeniedMessage(_: String)
    func setAccessDeniedButtonTitle(_: String)
    
    func setCropMode(_: MediaPickerCropMode)
    
    // startIndex - index of element in previous array of MediaPickerItem, new elements were added after that index
    var onItemsAdd: (([MediaPickerItem], _ startIndex: Int) -> ())? { get set }
    var onItemUpdate: ((MediaPickerItem, _ index: Int?) -> ())? { get set }
    var onItemAutocorrect: ((MediaPickerItem, _ isAutocorrected: Bool, _ index: Int?) -> ())? { get set }
    var onItemMove: ((_ sourceIndex: Int, _ destinationIndex: Int) -> ())? { get set }
    var onItemRemove: ((MediaPickerItem, _ index: Int?) -> ())? { get set }
    var onCropFinish: (() -> ())? { get set }
    var onCropCancel: (() -> ())? { get set }
    var onContinueButtonTap: (() -> ())? { get set }

    var onFinish: (([MediaPickerItem]) -> ())? { get set }
    var onCancel: (() -> ())? { get set }
}
