//
//  YYPhotoGroupsController.swift
//  PhotoPicker
//
//  Created by Dark Dong on 2017/6/24.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Photos

protocol YYPhotoGroupsControllerDelegate: class {
    func photoGroupsDidSelected(assets: [PHAsset])
}

open class YYPhotoGroupsController: UITableViewController {
    
    weak var delegate: YYPhotoGroupsControllerDelegate?
    
    var mediaType: PHAssetMediaType?
    
    public var groups: [PHAssetCollection] = []
    
    deinit {
        print(type(of: self), #function)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized: //3
                self.loadData()
            default:
                break
            }
        }
        let leftBar = UIBarButtonItem(title: "首页", style: .plain, target: self, action: #selector(leftBar(sender:)))
        self.navigationItem.leftBarButtonItem = leftBar
    }
    
    @objc func leftBar(sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isToolbarHidden = true
    }
    
    //called on non-main queue
    func loadData() {
        if groups.isEmpty {
            let result = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
            result.enumerateObjects({ (group, index, stop) in
                if group.assetCollectionSubtype == .smartAlbumUserLibrary {
                    self.groups.insert(group, at: 0)
                } else {
                    self.groups.append(group)
                }
            })
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    //MARK: - action
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
    }
}

extension YYPhotoGroupsController {
    //MARK: - UITableViewDataSource
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoGroupCell", for: indexPath) as! PhotoGroupCell
        cell.reuse(with: group, mediaType: mediaType)
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = groups[indexPath.row]
        var assets: [PHAsset] = []
        if let type = mediaType {
        PHAsset.fetchAssets(in: group, options: nil).enumerateObjects({ (asset, index, stop) in
            if asset.mediaType == type {
                assets.append(asset)
            }
        })
            delegate?.photoGroupsDidSelected(assets: assets)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

open class PhotoGroupCell: UITableViewCell {
    @IBOutlet var coverImageview: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    
    private var group: PHAssetCollection?

    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    open func reuse(with group: PHAssetCollection, mediaType: PHAssetMediaType?) {
        self.group = group
        if let result = PHAsset.fetchKeyAssets(in: group, options: nil), let keyAsset = result.firstObject {
            let options = PHImageRequestOptions()
            options.isNetworkAccessAllowed = true
            let size = coverImageview.frame.size
            let scale = UIScreen.main.scale
            let targetSize = CGSize(width: size.width * scale, height: size.height * scale)
            PHImageManager.default().requestImage(for: keyAsset, targetSize: targetSize, contentMode: .aspectFill, options: options) { [weak self] (image, info) in
                guard let strongSelf = self else {
                    return
                }
                if strongSelf.group == group {
                    strongSelf.coverImageview.image = image
                }
            }
        } else {
            coverImageview.image = nil
        }
        
        titleLabel.text = group.localizedTitle
        
        let result = PHAsset.fetchAssets(in: group, options: nil)
        let count: Int
        if let type = mediaType {
            count = result.countOfAssets(with: type)
        } else {
            count = result.count
        }
        countLabel.text = "(\(count))"
    }
}
