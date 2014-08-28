# Creating PDF in Ruby

This repository contains code samples that will become part of the "Creating PDF
in Ruby" book. Each example models a practical PDF generation use case,
implemented with PrawnPDF.

## Project overview

Our goal is to produce roughly a dozen different use cases, each of which
will demonstrate different Prawn features and document generation techniques.

So far, the following use cases have been implemented:

* Dynamic form letters (see `examples/form_letter`)
* Utility bill (see `examples/utility_bill` )

For a list of use cases we're interested in covering but have not implemented
yet, see `IDEAS.md`.

## Prerequisites

The code samples in this repository are meant to work with the latest
stable version of Ruby.

We make use of Bundler for handling our dependencies, which may at times
track unreleased development snapshots of Prawn. To install all necessary
dependencies, run `bundle install`.

Each example project also has its own `README.md` file, so be sure to read
those for project-specific requirements. Most of the time, you will
simply need to run `rake` to execute the code samples, and `rake console`
to run an `IRB` session with all necessary code loaded.

## Problems and Questions

Please use the issue tracker to contact me about any issues you run into.
Support is not limited to bug reports: I also want to hear about anything
that looks confusing, does not work as expected, etc.

Although I can't promise I'll be able to help, I'm also happy to discuss
issues related to adapting these code samples to use within your own projects.

If you'd rather discuss things privately, feel free to send an email to
gregory@practicingruby.com.
