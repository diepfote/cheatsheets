# rst - restructured text

## literal includes and code blocks

```text
.. _ghe-ssh-config-label:

Heading
~~~~~~~~~~~~~~

Text

.. code-block:: bash

  Include <some-path-to-a-ssh-config-file>

Some more text

.. literalinclude:: .ssh/config
    :language: bash

```

## internal reference - internal cross-reference

Create a ref:

```text
.. _some_label:
```

Reference it/use it:
**Hint**: `_` leading underscore not present on purpose.

```text
:ref:`some_label`
```

## external link

```text
`Text to display <https://thelink.com>`_
```
