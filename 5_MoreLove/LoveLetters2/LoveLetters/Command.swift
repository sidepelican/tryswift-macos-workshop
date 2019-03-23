import Foundation

private let gitreader = Bundle.main.path(forResource: "gitreader", ofType: nil)!
private let lovesyntax = Bundle.main.path(forResource: "lovesyntax", ofType: nil)!

/// Execute a Shell command and read output string from stdout
public func readShellCommandOutput(command: String, inDirectory: String?, completion: @escaping (Data?) -> Void) {
    DispatchQueue.global(qos: .userInteractive).async {
        let process = Process()
        process.launchPath = "/bin/sh"
        process.arguments = [
            "-c",
            command
        ]

        let output = Pipe()
        process.standardOutput = output
        process.launch()
        process.waitUntilExit()

        let data = output.fileHandleForReading.readDataToEndOfFile()
        completion(data)
    }
}

/// Retrieve a page of the current git commits
public func retrieveCommits(repo: String, page: String?, count: Int, completion: @escaping (Data?) -> Void) {
    var cmd = "\(gitreader) --remote --repo \"\(repo)\" --branch \"origin/master\" --page \(count)"
    if let lastCommit = page {
        cmd.append(contentsOf: " --from-commit \(lastCommit)")
    }
    readShellCommandOutput(command: cmd, inDirectory: nil, completion: completion)
}

/// Retrieve a colored HTML Git Diff
public func retrieveDiff(repo: String, commit: String, completion: @escaping (Data?) -> Void) {
    // what to do here?
    // you can call `lovesyntax -h` to figure out the syntax
    let cmd = "\(lovesyntax) --html --commit \"\(commit)\" --repo \"\(repo)\" --theme dark"
    readShellCommandOutput(command: cmd, inDirectory: nil, completion: completion)
}
