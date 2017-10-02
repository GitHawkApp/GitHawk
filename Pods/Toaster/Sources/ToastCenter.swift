/*
 * ToastCenter.swift
 *
 *            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *                    Version 2, December 2004
 *
 * Copyright (C) 2013-2015 Su Yeol Jeon
 *
 * Everyone is permitted to copy and distribute verbatim or modified
 * copies of this license document, and changing it is allowed as long
 * as the name is changed.
 *
 *            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 *
 *  0. You just DO WHAT THE FUCK YOU WANT TO.
 *
 */

import UIKit

open class ToastCenter {

  // MARK: Properties

  private let queue: OperationQueue = {
    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = 1
    return queue
  }()

  open var currentToast: Toast? {
    return self.queue.operations.first as? Toast
  }

  open static let `default` = ToastCenter()


  // MARK: Initializing

  init() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.deviceOrientationDidChange),
      name: .UIDeviceOrientationDidChange,
      object: nil
    )
  }


  // MARK: Adding Toasts

  open func add(_ toast: Toast) {
    self.queue.addOperation(toast)
  }


  // MARK: Cancelling Toasts

  open func cancelAll() {
    for toast in self.queue.operations {
      toast.cancel()
    }
  }


  // MARK: Notifications

  @objc dynamic func deviceOrientationDidChange() {
    if let lastToast = self.queue.operations.first as? Toast {
      lastToast.view.setNeedsLayout()
    }
  }

}
