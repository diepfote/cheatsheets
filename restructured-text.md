# rst - restructured text

## literal includes and code blocks

```
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

```
.. _some_label:
```

Reference it/use it:
**Hint**: `_` leading underscore not present on purpose.

```
:ref:`some_label`
```

