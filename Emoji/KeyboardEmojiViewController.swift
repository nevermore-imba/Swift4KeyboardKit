//
//  KeyboardEmojiViewController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public class KeyboardEmojiViewController: UICollectionViewController {

    var emojis = KeyboardEmojis.sharedInstance

    public weak var delegate: KeyboardEmojiViewControllerDelegate?

    public init() {
        let layout = KeyboardEmojiCollectionViewLayout()
        super.init(collectionViewLayout: layout)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()

        self.collectionView!.register(KeyboardEmojiCollectionViewCell.self, forCellWithReuseIdentifier: KeyboardEmojiCollectionViewCell.reuseIdentifier)
        self.collectionView!.register(KeyboardEmojiCollectionSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KeyboardEmojiCollectionSectionHeaderView.reuseIdentifier)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self

        self.collectionView!.backgroundColor = UIColor.clear
        self.collectionView!.backgroundView?.backgroundColor = UIColor.clear
    }

    public func scrollToEmojiCategory(emojiCategory: KeyboardEmojiCategory, animated: Bool) {
        guard let section = self.emojis.categories.firstIndex(of: emojiCategory) else { return }
        self.collectionView?.scrollToItem(at: IndexPath(item: 0, section: section), at: [.left, .top], animated: animated)
    }

    private var cachedEmojiCategory: KeyboardEmojiCategory = .None
    public var emojiCategory: KeyboardEmojiCategory {
        get {
            guard let indexPaths = self.collectionView?.indexPathsForVisibleItems, indexPaths.count > 0 else {
                return .None
            }

            // # Short version of Finding Majority Item algorithm
            var majoritySection = 0
            var count = 0

            for indexPath in indexPaths {
                if count == 0 {
                    majoritySection = indexPath.section
                }

                count += majoritySection == indexPath.section ? 1 : -1
            }

            return self.emojis.categories[majoritySection]
        }

        set {
            self.scrollToEmojiCategory(emojiCategory: newValue, animated: UIView.areAnimationsEnabled)
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.notifyAboutEmojiCategoryIfNeeded()
    }
}


extension KeyboardEmojiViewController /*: UICollectionViewDataSource */ {

    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.emojis.categories.count
    }

    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = self.emojis.categories[section]
        return self.emojis.emojisByCategory[category]!.count
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = self.emojis.categories[indexPath.section]
        let index = indexPath.row

        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: KeyboardEmojiCollectionViewCell.reuseIdentifier, for: indexPath) as! KeyboardEmojiCollectionViewCell
        let emoji = self.emojis.emojisByCategory[category]![index]
        cell.emoji = emoji
        return cell
    }

//    public override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        let category = self.emojis.categories[indexPath.section]
//        let index = indexPath.row
//
//        let headerView = self.collectionView?.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: KeyboardEmojiCollectionSectionHeaderView.reuseIdentifier, forIndexPath: indexPath) as! KeyboardEmojiCollectionSectionHeaderView
//        headerView.emojiCategory = category
//        return headerView
//    }

    private func notifyAboutEmojiCategoryIfNeeded() {
        let actiallyEmojiCategories = self.emojiCategory
        if self.cachedEmojiCategory != actiallyEmojiCategories {
            self.cachedEmojiCategory = actiallyEmojiCategories
            self.delegate?.emojiViewController(self, emojiCategoryWasChanged: actiallyEmojiCategories)
        }

    }
}


extension KeyboardEmojiViewController /*: UICollectionViewDelegate */ {

    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = self.emojis.categories[indexPath.section]
        let index = indexPath.row
        let emoji = self.emojis.emojisByCategory[category]![index]
        UIInputViewController.rootInputViewController.textDocumentProxy.insertText(emoji.character)
    }
}


extension KeyboardEmojiViewController {

    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.notifyAboutEmojiCategoryIfNeeded()
    }

}
