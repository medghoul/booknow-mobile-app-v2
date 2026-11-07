/// Height variant for buttons and other tappable controls.
enum ButtonSize { normal, small }

/// Which side of the label a button's icon sits on.
///
/// Leading is the Material default and suits an icon that names the action.
/// Trailing is for an icon that points at the *outcome* — the forward arrow on
/// "Avanti", which the design puts after the word because it reads as the
/// direction of travel, not as a glyph for the verb.
enum ButtonIconAffinity { leading, trailing }

/// Which of the three button treatments a control uses.
///
/// The design gives the product a single action colour, so only one filled
/// button should be visible in a view at a time; [outlined] and [text] carry
/// everything else.
enum ButtonVariant { filled, outlined, text }

/// The identity providers offered on the sign-in screen.
enum AuthProviderKind { apple, google }
